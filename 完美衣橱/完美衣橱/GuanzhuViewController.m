//
//  GuanzhuViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "GuanzhuViewController.h"
#import "AttentionCell.h"
#import "attentionModel.h"
#import "UIImageView+WebCache.h"
#import "WMString-Utilities.h"
#import "GuanzhuDetailViewController.h"

@interface GuanzhuViewController ()
#define kAttentionUrlString @"http://open.wanmeiyichu.com/api/flow.getList?uid=254512&key=e9ca2033904e333acfb1e3bd74d7ca09&pagesize=30&pg=%d&flow_size=450x0"

@end

@implementation GuanzhuViewController{
    NSMutableArray *_dataArray;    //记得初始化数组
    NSInteger currentPage;
    BOOL _isRefresh;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"我的关注";
    [_tableView registerNib:[UINib nibWithNibName:@"AttentionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    currentPage = 1;
    [self downloadWithPage:currentPage];
    _isLoding = NO;
    [self createHeaderView];
    
    
}

- (void)downloadWithPage:(NSInteger)page;
{
    NSString *url = [NSString stringWithFormat:kAttentionUrlString,page];
    [HttpRequest requestWithUrlString:url target:self];
}

//刷新头视图
- (void)createHeaderView{
    if (_headerView&&[_headerView superview]) {
        [_headerView removeFromSuperview];
    }
    _headerView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - 80, 320,80)];
    _headerView.delegate = self;
    [_headerView refreshLastUpdatedDate];
    [_tableView addSubview:_headerView];
}

//刷新尾视图
- (void)createFooterView
{
    if (_footerView) {
        [_footerView removeFromSuperview];
    }
    _footerView = [[EGORefreshTableFooterView alloc] initWithFrame:CGRectMake(0.0f,_tableView.contentSize.height, 320, 80)];
    _footerView.delegate = self;
    [_footerView refreshLastUpdatedDate];
    [_tableView addSubview:_footerView];
}

- (void)httpRequestFinished:(HttpRequest *)request
{
    if (_isRefresh) {
        [_dataArray removeAllObjects];
    }
    
    if (request.downloadData) {
        NSDictionary *myResult = [NSJSONSerialization JSONObjectWithData:request.downloadData options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dic = [myResult objectForKey:@"data"];
        NSArray *array = [dic objectForKey:@"reqdata"];
        for (NSDictionary *subdic in array) {
            attentionModel *model = [[attentionModel alloc] init];
            [model setValuesForKeysWithDictionary:subdic];
            [_dataArray addObject:model];
            
        }
    }
    
    [_headerView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableView];
    [_tableView reloadData];
    [self createFooterView];

    _isRefresh = NO;
}

- (void)httpRequestFailed:(HttpRequest *)request
{
    NSLog(@"请求失败");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    attentionModel *model = [_dataArray objectAtIndex:indexPath.row];
    CGFloat h =  (290.0*[model.thumb_height floatValue]/[model.thumb_width floatValue]) + 100.0;
    return h;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userCell = @"Cell";
    AttentionCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
    attentionModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell.avatarImageView setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.usernameLabel.text = model.username;
    NSString *str = [NSString timeStamp:model.flow_time];
    NSString *timeInterval = [NSString stringFromCurrent:str];
    cell.flow_timeLabel.text = timeInterval;
    CGRect rect = cell.flow_imageView.frame;
    rect.size.height = 290.0*[model.thumb_height floatValue]/[model.thumb_width floatValue];
    cell.flow_imageView.frame = rect;
    [cell.flow_imageView setImageWithURL:[NSURL URLWithString:model.flow_image]];
    CGFloat y = cell.flow_imageView.frame.origin.y+cell.flow_imageView.frame.size.height+5;
    CGRect y1 = cell.commmentLabel.frame;
    CGRect y2 = cell.CommmentBtn.frame;
    CGRect y3 = cell.LikeLabel.frame;
    CGRect y4 = cell.LikeBtn.frame;
    CGRect y5 = cell.ForwardLabel.frame;
    CGRect y6 = cell.ForwardBtn.frame;
    y1.origin.y = y;
    y2.origin.y = y+3;
    y3.origin.y = y;
    y4.origin.y = y+3;
    y5.origin.y = y;
    y6.origin.y = y+3;
    cell.commmentLabel.frame = y1;
    cell.CommmentBtn.frame = y2;
    cell.LikeLabel.frame = y3;
    cell.LikeBtn.frame = y4;
    cell.ForwardLabel.frame = y5;
    cell.ForwardBtn.frame = y6;
    cell.LikeLabel.text = model.like_num;
    cell.commmentLabel.text = model.comment_num;
    cell.ForwardLabel.text = model.forwards_num;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    attentionModel *model = [_dataArray objectAtIndex:indexPath.row];
    GuanzhuDetailViewController *gd = [[GuanzhuDetailViewController alloc] init];
    gd.flow_Id = model.flow_id;
    [self.navigationController pushViewController:gd animated:YES];
}

#pragma mark EGO Delegate 
- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    if (!_isLoding) {
        if (aRefreshPos == EGORefreshHeader) {
                 currentPage  = 1;
        [self downloadWithPage:currentPage];
        _isRefresh = YES;
        }
        if (aRefreshPos == EGORefreshFooter) {
            currentPage ++;
            [self downloadWithPage:currentPage];
        }
    }
}


- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view
{
    return  _isLoding;
}

- (NSDate *)egoRefreshTableDataSourceLastUpdated:(UIView *)view
{
    return [NSDate date];
}

// 判断拖拉是否触发事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_headerView){
        
        [_headerView egoRefreshScrollViewDidScroll:scrollView];
        
    }
    if (_footerView)
    {
        [_footerView egoRefreshScrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_headerView) {
        
        [_headerView egoRefreshScrollViewDidEndDragging:scrollView];

    }
    if (_footerView){
        
        [_footerView egoRefreshScrollViewDidEndDragging:scrollView];
        
    }
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
