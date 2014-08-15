//
//  GuanzhuDetailViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-11.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "GuanzhuDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "CustomTabBarController.h"
#import "AttentionDetailCell.h"
#import "AttentionDetailModel.h"
#import "WMString-Utilities.h"
#import "UMSocial.h"

@interface GuanzhuDetailViewController (){
    NSMutableArray *_dataArray;
}

#define kCommentUrlString @"http://open.wanmeiyichu.com/api/flow.getCommentList?sign=f3ae5fd1d3b24eb45215d7f866ca5a83&timestamp=1405998101&flow_id=%@&pagesize=30&pg=1"
#define kBozhuUrlString @"http://open.wanmeiyichu.com/api/flow.getInfo?sign=72c904359d288d7ee0dcc8813323f27d&timestamp=1405998086&flow_id=%@"

@end

@implementation GuanzhuDetailViewController

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
    
    AFHTTPRequestOperationManager *manager1 = [[AFHTTPRequestOperationManager alloc] init];
    [manager1 GET:[NSString stringWithFormat:kBozhuUrlString,_flow_Id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"flow_image"]]];
        _tableView.tableHeaderView = imageView;
       // NSLog(@"respose:%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
    }];
    
    
    AFHTTPRequestOperationManager *manager2 = [[AFHTTPRequestOperationManager alloc] init];
    [manager2 GET:[NSString stringWithFormat:kCommentUrlString,_flow_Id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"reqdata"];
        for (NSDictionary *subDic in array) {
            AttentionDetailModel *model = [[AttentionDetailModel alloc] init];
            model.headerView = [subDic objectForKey:@"avatar"];
            model.title = [subDic objectForKey:@"username"];
            model.time = [subDic objectForKey:@"time"];
            model.content = [subDic objectForKey:@"flow_comment_content"];
            [_dataArray addObject:model];
            
        }
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
    
    [_tableView registerNib:[UINib nibWithNibName:@"AttentionDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tool_btn_socialShare"] style:UIBarButtonItemStylePlain target:self action:@selector(shareImage)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)shareImage
{
    //为毛只有两个分享平台？
   [UMSocialSnsService presentSnsIconSheetView:self appKey:@"51c164ac56240b1648044f45" shareText:@"猪你的鼻子两个孔" shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,nil] delegate:self];
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"resposeCode : %d",response.responseCode);
    NSLog(@"response : %@",response.data);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userCell = @"Cell";
    AttentionDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
    AttentionDetailModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell.headerImageView setImageWithURL:[NSURL URLWithString:model.headerView]];
    cell.titleLabel.text = model.title;
    cell.contentLabel.text = model.content;
    cell.timeLabel.text = model.time;
    return cell;
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
