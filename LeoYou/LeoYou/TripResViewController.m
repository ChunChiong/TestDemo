//
//  TripResViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "TripResViewController.h"
#import "HttpRequestManager.h"
#import "UIScrollView+AH3DPullRefresh.h"
#import "SVProgressHUD.h"
#import "TripCell.h"
#import "TripModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "TripDetailViewController.h"

@interface TripResViewController () <HttpRequestManagerDelegate> {
    HttpRequestManager *_httpRequest;
}

@end

@implementation TripResViewController

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
    
    _currentPageTrip = 1;
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight] - 64 -49);
    //下拉刷新
    TripResViewController *vc = self;
    [self.tableView setPullToRefreshHandler:^{
        vc.isRefresh= YES;
        vc.isLoadMore = NO;
        [vc loadDataWithPage:1];
    }];
    //上拉加载
    [self.tableView setPullToLoadMoreHandler:^{
        vc.isRefresh = NO;
        vc.isLoadMore = YES;
        vc.currentPageTrip++;
        [vc loadDataWithPage:vc.currentPageTrip];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showCusTabBar];
    
    [self customBackBtn];
    [self setCustomTitle:self.searchKeyword];

    [self loadDataWithPage:1];
}

- (void)loadDataWithPage:(NSInteger)page
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    [self.dataArray removeAllObjects];
    //如果是刷新，或者Index改变，清空数据源
    if (_isRefresh) {
        [self.dataArray removeAllObjects];
    }
    NSString *urlStr = [NSString stringWithFormat:kURLSearchTrip, [self.searchKeyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], page];

    [_httpRequest requestDataWithURLStr:urlStr];
}

#pragma mark http request manage delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error %@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    if (_isRefresh) {
        [self.tableView refreshFinished];
    }
    if (_isLoadMore) {
        [self.tableView loadMoreFinished];
    }
    if ([data isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in data) {
            TripModel *model = [[TripModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.tripID = [[dict objectForKey:@"id"] integerValue];
            [self.dataArray addObject:model];
            [self.tableView reloadData];
        }
    }
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"trip";
    TripCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TripCell" owner:self options:nil] lastObject];
    }
    TripModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.TripBgImageView setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url]];
    [cell.TripUserBtn setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"image"]]];
    cell.TripNameLabel.text = model.name;
    NSString *info = [NSString stringWithFormat:@"%@|%d天%d图", model.start_date, model.days, model.photos_count];
    cell.TripInfoLabel.text = info;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripModel *model = [self.dataArray objectAtIndex:indexPath.row];
    TripDetailViewController *detail = [[TripDetailViewController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];

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
