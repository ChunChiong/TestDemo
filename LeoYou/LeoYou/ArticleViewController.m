//
//  ArticleViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-12.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "ArticleViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AritcleModel.h"
#import "ArticleCell.h"
#import "UIButton+WebCache.h"
#import "SubCell.h"
#import "UIImageView+WebCache.h"
#import "HttpRequestManager.h"
#import "SVProgressHUD.h"

@interface ArticleViewController () <HttpRequestManagerDelegate>{
    HttpRequestManager *_httpRequest;
}

@end

@implementation ArticleViewController

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
    self.tableView.allowsSelection = NO;
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createTableViewHeader];
    [self loadDataWithPage:1];
    
    [self hideCusTabBar];
    [self customBackBtn];
    [self shareBtn];
    [self setCustomTitle:self.subModel.name];
}

- (void)loadDataWithPage:(NSInteger)page
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    NSString *urlStr = [NSString stringWithFormat:KURLArticle, self.subModel.subID, page];
    [_httpRequest requestDataWithURLStr:urlStr];
}

#pragma mark httpRequest delegate
- (void)httpLoadDataSuccess:(id)data
{
    if (![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSArray *articelSections = [data objectForKey:@"article_sections"];
    for (NSDictionary *dict in articelSections) {
        AritcleModel *model = [[AritcleModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        model.AttractionID = [[[dict objectForKey:@"attraction"] objectForKey:@"id"] integerValue];
        model.AttractionName = [[dict objectForKey:@"attraction"] objectForKey:@"name"];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error:%@", error);
}

- (void)createTableViewHeader
{
    SubCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"SubCell" owner:self options:nil] lastObject];
    cell.frame = CGRectMake(0, 0, 300, 180);
    [cell.subBgImageView setImageWithURL:[NSURL URLWithString:self.subModel.image_url]];
    cell.subNameLabel.text = self.subModel.name;
    cell.subTitleLabel.text = self.subModel.title;
    CGRect rect = cell.subBgImageView.frame;
    rect.size.width = 320.f;
    rect.origin.x = 0;
    cell.subBgImageView.frame = rect;
    
    self.tableView.tableHeaderView = cell;
}

#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getHeightOfRowAtIndexPath:indexPath];
}

- (CGFloat)getHeightOfRowAtIndexPath:(NSIndexPath *)indexPath
{
    AritcleModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CGFloat height = 10.f;
    if (model.image_url.length > 0) {
        height += [model getImgHeight];
    }
    
    if (model.description.length > 0) {
        height += 5;
        height += [model getDesHeight];
    }
    
    if (model.AttractionName.length > 0) {
        height += 5;
        height += 20;
    }
    //buttomLabel
    height += 8;
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"article";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil] lastObject];
    }
    AritcleModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CGRect imgFrame = CGRectMake(10, 10, 300, 20);
    if (model.image_url.length > 0) {
        [cell.articleImgBtn setImageWithURL:[NSURL URLWithString:model.image_url]];
        imgFrame.size.height = [model getImgHeight];
        cell.articleImgBtn.frame = imgFrame;
        cell.articleImgBtn.hidden = NO;
    } else {
        imgFrame.size.height = 0;
        cell.articleImgBtn.hidden = YES;
    }
    
    CGRect desFrame = CGRectMake(10, imgFrame.origin.y + imgFrame.size.height + 5, 300, 100);
    if (model.description.length > 0) {
        cell.articleDesLabel.text = model.description;
        desFrame.size.height = [model getDesHeight];
        cell.articleDesLabel.frame = desFrame;
        cell.articleDesLabel.hidden = NO;
    } else {
        desFrame.size.height = 0;
        cell.articleDesLabel.hidden = YES;
    }
    
    CGRect locImgFrame = CGRectMake(10, desFrame.origin.y + desFrame.size.height + 5, 10, 14);
    CGRect locNameFrame = CGRectMake(28, locImgFrame.origin.y, 88, 16);
    if (model.AttractionName.length > 0) {
        [cell.articleLocName setTitle:model.AttractionName forState:UIControlStateNormal];
        cell.articleLocName.frame = locNameFrame;
        cell.articleLocImg.frame = locImgFrame;
        cell.articleLocName.hidden = NO;
        cell.articleLocImg.hidden = NO;
    } else {
        locImgFrame.size.height = 0;
        locNameFrame.size.height = 0;
        cell.articleLocImg.hidden = YES;
        cell.articleLocName.hidden = YES;
    }
    
    CGRect bottomLabelFrame = CGRectMake(10, locImgFrame.origin.y + locImgFrame.size.height +5, 300, 1);
    cell.articleBottomLabel.frame = bottomLabelFrame;
    
    return cell;
}

- (void)shareBtnClick
{
    NSString *message = [NSString stringWithFormat:@"#LeoYou#:%@", self.subModel.title];
    [self shareWithMessage:message];
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
