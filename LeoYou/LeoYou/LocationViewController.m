//
//  LocationViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "LocationViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "LocationModel.h"
#import "LocationCell.h"
#import "UIImageView+WebCache.h"
#import "HttpRequestManager.h"
#import "UIScrollView+AH3DPullRefresh.h"
#import "SVProgressHUD.h"
#import "AttractionViewController.h"

@interface LocationViewController () <HttpRequestManagerDelegate> {
    HttpRequestManager *_httpRequest;
}

@end

@implementation LocationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCustomTitle:@"目的地"];
    [self customBackBtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight]-64);
    
    // Do any additional setup after loading the view.
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
    
    LocationViewController *vc = self;
    [self.tableView setPullToRefreshHandler:^{
        vc.isLoadMore = NO;
        vc.isRefresh = YES;
        vc.currentPage = 1;
        [vc loadDataWithPage:1];
    }];
    
    _currentPage = 1;
    [self.tableView setPullToLoadMoreHandler:^{
        vc.isRefresh = NO;
        vc.isLoadMore = YES;
        vc.currentPage++;
        [vc loadDataWithPage:vc.currentPage];
    }];
    
    [self loadDataWithPage:1];
}

- (void)loadDataWithPage:(NSInteger)page
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    if (_isRefresh) {
        [self.dataArray removeAllObjects];
    }
    NSString *urlStr = [NSString stringWithFormat:kURLLocation, self.locationID, page];
    NSLog(@"%@", urlStr);
    [_httpRequest requestDataWithURLStr:urlStr];
}

#pragma mark http request delegate
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
            LocationModel *model = [[LocationModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.locationID = [[dict objectForKey:@"id"] integerValue];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }
}

- (void)httpLoadDataFailed:(NSString *)error
{
    if (_isRefresh) {
        [self.tableView refreshFinished];
    }
    if (_isLoadMore) {
        [self.tableView loadMoreFinished];
    }
    NSLog(@"error %@", error);
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"location";
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LocationCell" owner:self options:nil] lastObject];
    }
    LocationModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.locImageVIew setImageWithURL:[NSURL URLWithString:model.image_url]];
    cell.locNumLabel.text = [NSString stringWithFormat:@"%d", model.attraction_trips_count];
    cell.locNameLabel.text = model.name;
    cell.locDescLabel.text = model.description_summary;
    [cell.locStarView setWidthWithScore:[model.user_score floatValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationModel *model = [self.dataArray objectAtIndex:indexPath.row];
    AttractionViewController *vc = [[AttractionViewController alloc] init];
    vc.locationID = model.locationID;
    vc.locationName = model.name;
    [self.navigationController pushViewController:vc animated:YES];
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
