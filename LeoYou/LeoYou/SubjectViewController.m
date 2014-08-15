//
//  SubjectViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "SubjectViewController.h"
#import "HttpRequestManager.h"
#import "SubModel.h"
#import "SubCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "SVProgressHUD.h"
#import "ArticleViewController.h"


@interface SubjectViewController () <HttpRequestManagerDelegate> {
    HttpRequestManager *_httpManager;
}

@end

@implementation SubjectViewController

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
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight] - 64);
    _httpManager = [[HttpRequestManager alloc] init];
    _httpManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataWithPage:1];
    [self customBackBtn];
    [self setCustomTitle:@"专题"];
    [self hideCusTabBar];
}

#pragma mark 请求数据
- (void)loadDataWithPage:(NSInteger)page
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    NSString *urlStr = [NSString stringWithFormat:kURLDesSub, self.subID, page];
    [_httpManager requestDataWithURLStr:urlStr];
    
}

#pragma http request delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"%@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    for (NSDictionary *dict in data) {
        SubModel *model = [[SubModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        model.subID = [[dict objectForKey:@"id"] integerValue];
        [self.dataArray addObject:model];
        [self.tableView reloadData];
    }
}

#pragma mark taleView delegate
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubModel *model = [self.dataArray objectAtIndex:indexPath.row];
    ArticleViewController *article = [[ArticleViewController alloc] init];
    article.subModel = model;
    [self.navigationController pushViewController:article animated:YES];
    return;
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
