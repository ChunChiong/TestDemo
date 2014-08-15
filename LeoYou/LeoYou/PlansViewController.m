//
//  PlansViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "PlansViewController.h"
#import "SVProgressHUD.h"
#import "HttpRequestManager.h"
#import "PlanNodeModel.h"
#import "PlanNodeCell.h"
#import "UIImageView+WebCache.h"
#import "MapAttractionViewController.h"

@interface PlansViewController () <HttpRequestManagerDelegate> {
    HttpRequestManager *_httpRequest;
    NSMutableArray *_sectionArray;//用于保存section的信息
}

@end

@implementation PlansViewController

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
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight] - 64);
    
    [self hideCusTabBar];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCustomTitle:self.travel.name];
    [self customBackBtn];
    [self mapBtn];
}

#pragma mark 请求数据
- (void)loadData
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    NSString *urlStr = [NSString stringWithFormat:kURLPlansDetail, self.travel.travelID];
    [_httpRequest requestDataWithURLStr:urlStr];
}


#pragma mark http request delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error %@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    if ([data isKindOfClass:[NSDictionary class]]) {
        //加上坐标信息
        _travel.destination = [data objectForKey:@"destination"];
        NSArray *planDays = [data objectForKey:@"plan_days"];
        //获取每天的nodes
        for (NSDictionary *planDayDict in planDays) {
            NSMutableArray *dayArray = [[NSMutableArray alloc] init];
            //为section准备显示的素材
            [_sectionArray addObject:[planDayDict objectForKey:@"memo"]];
            //开始准备planNodes
            for (NSDictionary *PlanNodesDict in [planDayDict objectForKey:@"plan_nodes"]) {
                PlanNodeModel *model = [[PlanNodeModel alloc] init];
                [model setValuesForKeysWithDictionary:PlanNodesDict];
                [dayArray addObject:model];
            }
            [self.dataArray addObject:dayArray];
        }
        [self.tableView reloadData];
    }
}

#pragma mark tableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightOfCellAtIndexPath:indexPath];
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
    static NSString *cellID = @"plan";
    PlanNodeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlanNodeCell" owner:self options:nil] lastObject];
    }
    PlanNodeModel *model = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *titleInfo = [NSString stringWithFormat:@"第%d天第%d站:%@", indexPath.section+1, model.position+1, model.entry_name];
    cell.planTitleLabel.text = titleInfo;
    CGRect imgFrame = CGRectMake(40, 85, 266, 0);
    if (model.image_url.length > 0) {
        imgFrame.size.height = 169;
        cell.planTipsImg.frame = imgFrame;
        [cell.planTipsImg setImageWithURL:[NSURL URLWithString:model.image_url]];
        cell.planTipsImg.hidden = NO;
    } else {
        cell.planTipsImg.hidden = YES;
    }
    
    CGRect tipsFrame = CGRectMake(50, imgFrame.origin.y + 2 +imgFrame.size.height, 247, 0);
    CGFloat tipsHeight = [model getTipsHeight];
    if (model.tips.length > 0) {
        tipsFrame.size.height = tipsHeight;
        cell.planDesLabel.frame = tipsFrame;
        cell.planDesLabel.text = model.tips;
        cell.planDesLabel.hidden = NO;
    } else {
        cell.planDesLabel.hidden = YES;
    }
    
    CGFloat DesImgHeight = 2 + imgFrame.size.height + 20+tipsFrame.size.height +2;
    CGRect desImgFrame = cell.planDesImg.frame;
    desImgFrame.size.height = DesImgHeight;
    cell.planDesImg.frame = desImgFrame;
    
    cell.planDesLabel.text = model.tips;
    
    CGRect lineFrame = cell.planLineLabel.frame;
    lineFrame.size.height = [self getHeightOfCellAtIndexPath:indexPath];
    cell.planLineLabel.frame = lineFrame;
    
    return cell;
}

- (CGFloat)getHeightOfCellAtIndexPath:(NSIndexPath *)indexPath
{
    PlanNodeModel *model = [[self.dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CGFloat height = 71;
    if (model.image_url.length > 0) {
        height += 169;
    }
    if (model.tips.length > 0) {
        height += 2+ [model getTipsHeight];
    }
    height += 20 + 2;
    return  height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@"hello");
    PlanNodeCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PlanNodeCell" owner:self options:nil] lastObject];
    NSString *des = [_sectionArray objectAtIndex:section];
    
    cell.planDayIcon.hidden = NO;
    cell.planDayInfoLabel.hidden = NO;
    cell.planTitleLabel.text = @"简介";
    cell.planDayInfoLabel.text = [NSString stringWithFormat:@"DAY%d", section+1];
    cell.planDesLabel.text = des;
    cell.planTipsImg.hidden = YES;
    
    CGRect desframe = CGRectMake(40, 85, 266, 0);
    desframe.size.height = [self heightForDes:des];
    cell.planDesLabel.frame = desframe;
    
    CGRect lineframe = cell.planLineLabel.frame;
    lineframe.size.height = desframe.origin.y + [self heightForDes:des] + 20;
    cell.planLineLabel.frame = lineframe;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)heightForDes:(NSString *)des
{
    if (des.length > 0) {
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGRect frame = [des boundingRectWithSize:CGSizeMake(247, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        return frame.size.height;
    } else {
        return 0;
    }
}

//呼出地图
- (void)mapBtnClicked
{
    MapAttractionViewController *map = [[MapAttractionViewController alloc] init];
    map.title = self.travel.name;
    map.nodesArray = self.dataArray;
    [self.navigationController pushViewController:map animated:YES];

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
