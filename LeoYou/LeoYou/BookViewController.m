//
//  BookViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "BookViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "BookModel.h"
#import "BookCell.h"
#import "UIButton+WebCache.h"

#import "TravelViewController.h"
#import "LocationViewController.h"

#import "HttpRequestManager.h"
#import "SubjectViewController.h"
#import "SVProgressHUD.h"

@interface BookViewController () <HttpRequestManagerDelegate> {
    NSInteger _currentRow;//用于记录当前被选中的cell
    HttpRequestManager *_httpRequest;
}

@end

@implementation BookViewController

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
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight] - 64);
    _currentRow = -1;
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.allowsSelection = NO;
    //消除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self customBackBtn];
    [self setCustomTitle:self.bookName];
    [self hideCusTabBar];
    [self loadDataWithPage:1];
}

- (void)loadDataWithPage:(NSInteger)page
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    [self.dataArray removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:KURLBook, self.bookID, page];
    [_httpRequest requestDataWithURLStr:urlStr];
}

#pragma mark http request delegate
- (void)httpLoadDataSuccess:(id)data
{
    if ([data isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in data) {
            BookModel *book = [[BookModel alloc] init];
            [book setValuesForKeysWithDictionary:dict];
            book.bookID = [[dict objectForKey:@"id"] integerValue];
            [self.dataArray addObject:book];
        }
        [self.tableView reloadData];
    }
}

- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error:%@", error);
}


#pragma mark tableView delegate
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
    if (indexPath.row == _currentRow) {
        return 409.f;
    } else {
        return 190.f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"table cell");
    static NSString *cellID = @"book";
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BookCell" owner:self options:nil] lastObject];
    }
    BookModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.bookCnLabel.text = model.name_zh_cn;
    cell.bookEnLabel.text = model.name_en;
    [cell.bookImgBtn setImageWithURL:[NSURL URLWithString:model.image_url]];
    [cell.bookImgBtn addTarget:self action:@selector(bookImgBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.bookImgBtn.tag = indexPath.row*100 + 99;
    
    cell.bookSubNumLabel.text = [NSString stringWithFormat:@"%d个", model.articles_count];
    cell.bookTripNumLabel.text = [NSString stringWithFormat:@"%d个", model.plans_count];
    cell.bookDesNumLabel.text = [NSString stringWithFormat:@"%d个", model.poi_count];
    
    //todo
    //下面的button都不能点
    [cell.bookSubBtn addTarget:self action:@selector(bookSubBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    cell.bookSubBtn.tag = model.bookID;//用bookID作为tag
    
    [cell.bookTripBtn addTarget:self action:@selector(bookTripBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.bookTripBtn.tag = model.bookID + 1;
    
    [cell.bookDesBtn addTarget:self action:@selector(bookDesBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.bookDesBtn.tag = model.bookID + 2;
    
    [cell.bookTipsBtn addTarget:self action:@selector(bookTipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.bookTipsBtn.tag = model.bookID + 3;
    
    return cell;
}

- (void)bookSubBtnCliked:(UIButton *)btn
{
    SubjectViewController *sub = [[SubjectViewController alloc] init];
    sub.subID = btn.tag;
    [self.navigationController pushViewController:sub animated:YES];
}

- (void)bookTripBtnClicked:(UIButton *)btn
{
    TravelViewController *travel = [[TravelViewController alloc] init];
    travel.travalID = btn.tag - 1;
    [self.navigationController pushViewController:travel animated:YES];
}

- (void)bookDesBtnClicked:(UIButton *)btn
{
    LocationViewController *location = [[LocationViewController alloc] init];
    location.locationID = btn.tag - 2;
    [self.navigationController pushViewController:location animated:YES];
}

- (void)bookTipBtnClicked:(UIButton *)btn
{
    NSLog(@"tip");
}

- (void)bookImgBtnClicked:(UIButton *)btn
{
    _currentRow = (btn.tag - 99)/100;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_currentRow inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
