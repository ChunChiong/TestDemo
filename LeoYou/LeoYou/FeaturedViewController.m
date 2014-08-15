//
//  FeaturedViewController.m
//  LeoYou
//
//  Created by 赵 辉 on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "FeaturedViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "TripModel.h"
#import "TripCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "TripDetailViewController.h"
#import "SubModel.h"
#import "SubCell.h"
#import "ArticleViewController.h"
#import "UIScrollView+AH3DPullRefresh.h"
#import "SVProgressHUD.h"

@interface FeaturedViewController () {
    UISegmentedControl *_seg;
    NSInteger _currentPageTrip;
    NSInteger _currentPageSub;
    BOOL _isSegIndexChanged;
    HttpRequestManager *_httpManager;
}

@end

@implementation FeaturedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.view.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //定制search按钮
//    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    searchBtn.frame = CGRectMake(0, 0, 44, 44);
//    [searchBtn setImage:[UIImage imageNamed:@"SearchRightBarButton"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
//    [self setNavigationItemWithItem:searchItem isLeft:NO];
    
    [self createSegmentControl];
    self.tableView.frame = CGRectMake(0, 46, 320, [DeviceManager screenHeight] - 64 - 49 - 48);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _httpManager = [[HttpRequestManager alloc] init];
    _httpManager.delegate = self;

    _currentPageTrip = 1;
    _currentPageSub = 1;
    //下拉刷新
    FeaturedViewController *vc = self;
    [self.tableView setPullToRefreshHandler:^{
        vc.isRefresh= YES;
        vc.isLoadMore = NO;
        [vc loadDataWithPage:1];
    }];
    //上拉加载
    [self.tableView setPullToLoadMoreHandler:^{
        vc.isRefresh = NO;
        vc.isLoadMore = YES;
        if(vc.seg.selectedSegmentIndex == 0){
            vc.currentPageTrip++;
            [vc loadDataWithPage:vc.currentPageTrip];
        } else {
            vc.currentPageSub++;
            [vc loadDataWithPage:vc.currentPageSub];
        }
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCustomTitle:@"蝉游记"];
    //加载默认内容
    [self loadDataWithPage:1];
    
    [self showCusTabBar];
}

//创建segmentControl
- (void)createSegmentControl
{
    UILabel *bgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 48)];
    bgLabel.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:239/255.0 alpha:1];
    bgLabel.userInteractionEnabled = YES;
    [self.view addSubview:bgLabel];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"游记", @"专题", nil];
    _seg = [[UISegmentedControl alloc] initWithItems:titleArray];
    _seg.frame = CGRectMake(10, 10, 300, 29);
    [_seg setTintColor:[UIColor lightGrayColor]];
    _seg.selectedSegmentIndex = 0;
    [_seg addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    [bgLabel addSubview:_seg];
}


//当search按钮被点击
- (void)searchBtnClicked
{
    NSLog(@"haha");
}

//当segment的值改变
- (void)segmentValueChanged:(UISegmentedControl *)seg
{
    _isSegIndexChanged = YES;
    [self loadDataWithPage:1];
}

//加载对应的内容
- (void)loadDataWithPage:(NSInteger)page
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    //如果是刷新，或者Index改变，清空数据源
    if (_isRefresh || _isSegIndexChanged) {
        [self.dataArray removeAllObjects];
    }
    //change the flag back
    _isSegIndexChanged = NO;
    
    NSInteger index = _seg.selectedSegmentIndex;
    if (index == 0) {
        NSString *urlStr = [NSString stringWithFormat:kURLfeatured, page];
        [_httpManager requestDataWithURLStr:urlStr];
    } else {
        NSString *urlStr = [NSString stringWithFormat:kURLSub, page];
        [_httpManager requestDataWithURLStr:urlStr];
    }
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
    NSInteger index = _seg.selectedSegmentIndex;
    if (index == 0) {
        if ([data isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data) {
                TripModel *model = [[TripModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                model.tripID = [[dict objectForKey:@"id"] integerValue];
                [self.dataArray addObject:model];
                [self.tableView reloadData];
            }
        }
    } else {
        for (NSDictionary *dict in data) {
            SubModel *model = [[SubModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.subID = [[dict objectForKey:@"id"] integerValue];
            [self.dataArray addObject:model];
            [self.tableView reloadData];
        }
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
    NSLog(@"request error:%@", error);
}





#pragma mark tableview delegate
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
    if (_seg.selectedSegmentIndex == 0) {
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
    } else {
        static NSString *subCellID = @"sub";
        SubCell *subCell = [tableView dequeueReusableCellWithIdentifier:subCellID];
        if (subCell == nil) {
            subCell = [[[NSBundle mainBundle] loadNibNamed:@"SubCell" owner:self options:nil] lastObject];
        }
        SubModel *subModel = [self.dataArray objectAtIndex:indexPath.row];
        [subCell.subBgImageView setImageWithURL:[NSURL URLWithString:subModel.image_url]];
        subCell.subNameLabel.text = subModel.name;
        subCell.subTitleLabel.text = subModel.title;
        return subCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_seg.selectedSegmentIndex == 0) {
        TripModel *model = [self.dataArray objectAtIndex:indexPath.row];
        TripDetailViewController *detail = [[TripDetailViewController alloc] init];
        //使用Group样式的tableView
        //detail.isGroup = YES;
        detail.model = model;
        [self.navigationController pushViewController:detail animated:YES];
    } else {
        SubModel *model = [self.dataArray objectAtIndex:indexPath.row];
        ArticleViewController *article = [[ArticleViewController alloc] init];
        article.subModel = model;
        [self.navigationController pushViewController:article animated:YES];
        return;
    }
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
