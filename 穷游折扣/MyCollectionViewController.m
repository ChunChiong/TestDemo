//
//  MyCollectionViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyNavigationBar.h"
#import "CategoryViewController.h"
#import "DeviceManager.h"
#import "CollectionCell.h"
#import "SafeDBManager.h"
#import "UMSocial.h"
#import "outlineModel.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"

@interface MyCollectionViewController (){
    NSMutableArray *_dataArray;
    UITableView *_tableView;
}

@end

@implementation MyCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)bbiClick{
    //抽屉
    CategoryViewController *left = [[CategoryViewController alloc] init];
    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)createTableView{
    NSInteger height = [DeviceManager currentScreenHeight];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, height-64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0f];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    [self.view addSubview:_tableView];
    
}

- (void)createNavigationBar{
    MyNavigationBar *mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"我的收藏" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_drawer"] andRigtBBIImageName:nil andClass:self andSEL:@selector(bbiClick)];
    [self.view addSubview:mnb];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    _dataArray = [[NSMutableArray alloc]init];
    
    [self createNavigationBar];
    [self createTableView];
    [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
    NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
    UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
    NSString *loginName = sinaAccount.userName;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *userArray = [[SafeDBManager shareManager]fetchAllUsersWithLoginName:loginName];
        [_dataArray addObjectsFromArray:userArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
    
}

#pragma -mark tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *userCell = @"userCell";
    CollectionCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:userCell];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectionCell" owner:self options:nil]lastObject];
    }
    outlineModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.titleLabel.text = model.title;
    cell.priceLabel.text = model.price;
    return cell;
}



- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    outlineModel *model = [_dataArray objectAtIndex:indexPath.row];
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc.flag=1;
    dvc.model = model;
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:dvc];
    [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
