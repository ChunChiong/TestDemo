//
//  AttractionViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "AttractionViewController.h"
#import "HttpRequestManager.h"
#import "AttractionModel.h"
#import "SubAttractionModel.h"
#import "UIImageView+WebCache.h"
#import "ImgScrollView.h"
#import "SubAttrCell.h"
#import "SVProgressHUD.h"

@interface AttractionViewController ()<HttpRequestManagerDelegate> {
    HttpRequestManager *_httpManager;
    NSMutableArray *_sectionNameArray;
}

@end

@implementation AttractionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //修改tableViewFrame
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight] - 64);
    self.tableView.allowsSelection = NO;
    
    _httpManager = [[HttpRequestManager alloc] init];
    _httpManager.delegate = self;
    
    _sectionNameArray = [[NSMutableArray alloc] init];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCustomTitle:self.locationName];
    [self customBackBtn];
}

#pragma mark http manager delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error %@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        //获取attraction的基本信息
        AttractionModel *attr = [[AttractionModel alloc] init];
        [attr setValuesForKeysWithDictionary:data];
        
        //创建headview
        [self createHeadViewWithModel:attr];
        
        //获取subAttr的组
        NSArray *attrTripTagsArray = [data objectForKey:@"attraction_trip_tags"];
        for (NSDictionary *subTagsDict in attrTripTagsArray) {
            //获取组名
            [_sectionNameArray addObject:[subTagsDict objectForKey:@"name"]];
            //获取组下，所有的attraction
            NSArray *attrContentsArray = [subTagsDict objectForKey:@"attraction_contents"];
            NSMutableArray *subAttrArray = [[NSMutableArray alloc] init];
            for (NSDictionary *subAttr in attrContentsArray) {
                SubAttractionModel *subModel = [[SubAttractionModel alloc] init];
                [subModel setValuesForKeysWithDictionary:subAttr];
                [subAttrArray addObject:subModel];
            }
            [self.dataArray addObject:subAttrArray];
        }
        [self.tableView reloadData];
    }
}

- (void)createHeadViewWithModel:(AttractionModel *)model
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imgView setImageWithURL:[NSURL URLWithString:model.image_url]];
    [view addSubview:imgView];
    imgView.userInteractionEnabled = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 185, 300, 75)];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:14];
    label.text = model.description;
    [view addSubview:label];
    
    //todo设置地图按钮
    
    self.tableView.tableHeaderView = view;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 300.f;
    return [self getHeightOfCellAtIndexPath:indexPath];
}

- (CGFloat)getHeightOfCellAtIndexPath:(NSIndexPath *) indexPath
{
    SubAttractionModel *model = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CGFloat height = 0;
    if (model.description.length > 0) {
        height += 5 + [model getDescriptionHeight];
    }
    
    if (model.notes.count > 0) {
        height += 10 + 100;
    }
    
    height += 5+21+10;
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"subAttr";
    SubAttrCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SubAttrCell" owner:self options:nil] lastObject];
    }
    SubAttractionModel *model = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    cell.attrDesLabel.text = model.description;
//    cell.attrScrollView.photoArray = model.notes;
//    [cell.attrScrollView createScrollView];
    
    CGRect desFrame = CGRectMake(10, 5, 300, 0);
    if (model.description.length > 0) {
        desFrame.size.height = [model getDescriptionHeight];
        //NSLog(@"%f", model.getDescriptionHeight);
        cell.attrDesLabel.numberOfLines = 0;
        cell.attrDesLabel.frame = desFrame;
        cell.attrDesLabel.text = model.description;
        cell.attrDesLabel.hidden = NO;
    } else {
        cell.attrDesLabel.hidden = YES;
    }
    
    CGRect scrollFrame = CGRectMake(10, desFrame.origin.y+desFrame.size.height+10, 300, 0);
    if ([model.notes count] > 0) {
        scrollFrame.size.height = 100;
        cell.attrScrollView.frame = scrollFrame;
        cell.attrScrollView.photoArray = model.notes;
        [cell.attrScrollView createScrollView];
        cell.attrScrollView.hidden = NO;
    } else {
        cell.attrScrollView.hidden = YES;
    }

    CGRect dateFrame = CGRectMake(10, scrollFrame.origin.y+scrollFrame.size.height+5, 300, 21);
    cell.attrDateLabel.frame = dateFrame;
    cell.attrDateLabel.text = [model getDateStr];
    
    cell.attrBottomLine.frame = CGRectMake(0, dateFrame.origin.y+dateFrame.size.height+5, 320, 1);
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionNameArray objectAtIndex:section];
}



#pragma mark 请求数据
- (void)loadData
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    NSString *urlStr = [NSString stringWithFormat:kURLAttractionDetail, self.locationID];
    [_httpManager requestDataWithURLStr:urlStr];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
