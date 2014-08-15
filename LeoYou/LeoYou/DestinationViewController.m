//
//  DestinationViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "DestinationViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "DesModel.h"
#import "DesCell.h"
#import "UIButton+WebCache.h"
#import "BookViewController.h"
#import "UIScrollView+AH3DPullRefresh.h"
#import "HttpRequestManager.h"
#import "SVProgressHUD.h"

@interface DestinationViewController () <HttpRequestManagerDelegate>{
    HttpRequestManager *_httpRequest;
}

@end

@implementation DestinationViewController

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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight] - 64 - 49);
    self.tableView.allowsSelection = NO;
    __weak DestinationViewController *vc = self;
    [self.tableView setPullToRefreshHandler:^{
        vc.isRefresh = YES;
        [vc loadDataWithPage:1];
    }];
    
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
}

- (void)loadDataWithPage:(NSInteger)page
{
    [self.dataArray removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:KURLDes, page];
    [_httpRequest requestDataWithURLStr:urlStr];
    if (_isRefresh) {
        [self.tableView refreshFinished];
    }
}

#pragma mark httprequest delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error:%@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    if (![data isKindOfClass:[NSArray class]]) {
        return;
    }
    for (NSDictionary *dict in data) {
        NSMutableArray *desGroup = [[NSMutableArray alloc] init];
        NSArray *desArray = [dict objectForKey:@"destinations"];
        for (NSDictionary *subDes in desArray) {
            DesModel *model = [[DesModel alloc] init];
            
            [model setValuesForKeysWithDictionary:subDes];
            model.desID = [[subDes objectForKey:@"id"] integerValue];
            [desGroup addObject:model];
        }
        [self.dataArray addObject:desGroup];
    }
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = YES;
    [self setCustomTitle:@"旅行口袋书"];
    [self showCusTabBar];
    [self loadDataWithPage:1];
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sectionCount = [[self.dataArray objectAtIndex:section] count];
    return (sectionCount / 2) + (sectionCount%2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"des";
    DesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DesCell" owner:self options:nil] lastObject];
    }
    DesModel *leftmodel = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row*2];
    [cell.DesLeftButton setImageWithURL:[NSURL URLWithString:leftmodel.image_url]];
    //将id给button作为tag,以便交互
    cell.DesLeftButton.tag = leftmodel.desID;
    [cell.DesLeftButton addTarget:self action:@selector(desButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.desLeftNumLabel.text = [NSString stringWithFormat:@"%d", leftmodel.poi_count];
    cell.desLeftCnLabel.text = leftmodel.name_zh_cn;
    cell.desLeftEnLabel.text = leftmodel.name_en;
    //如果右边的个数仍在数组范围内，就设置右边的按钮
    if ((indexPath.row *2 + 1) < [[self.dataArray objectAtIndex:indexPath.section] count]) {
        DesModel *rightmodel = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row*2+1];
        [cell.desRightButton setImageWithURL:[NSURL URLWithString:rightmodel.image_url]];
        cell.desRightNumLabel.text = [NSString stringWithFormat:@"%d", rightmodel.poi_count];
        cell.desRightButton.tag = rightmodel.desID;
        [cell.desRightButton addTarget:self action:@selector(desButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.desRightCnLabel.text = rightmodel.name_zh_cn;
        cell.desRightEnLabel.text = rightmodel.name_en;
    } else {
        cell.desRightCnLabel.hidden = YES;
        cell.desRightNumLabel.hidden = YES;
        cell.desRightEnLabel.hidden = YES;
        cell.desRightButton.hidden = YES;
    }
    
    
    return cell;
}

- (void)desButtonClick:(UIButton*) button
{
    BookViewController *book = [[BookViewController alloc] init];
    book.bookID = button.tag;
    book.bookName = @"口袋书";
    [self.navigationController pushViewController:book animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *titleArray = @[@"国外-亚洲", @"国外-欧洲", @"美洲、大洋洲、非洲与南极洲", @"国内-港澳台", @"国内-大陆",];
    return [titleArray objectAtIndex:section];
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
