//
//  CategoryViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "CategoryViewController.h"
#import "MyCollectionViewController.h"
#import "ShowViewController.h"
#import "MoreSettingViewController.h"
#import "LoginViewController.h"
#import "DeviceManager.h"
@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createButton{
    NSArray *titleArray = @[@"全部折扣",@"我的订单",@"我的收藏",@"我的提醒",@"更多设置"];
    for (int i = 0; i<5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 100+i*60, 264, 60);
        [button setBackgroundImage:[UIImage imageNamed:@"drawer_cell_selected"] forState:UIControlStateSelected];
        [button setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
        if (i==0) {
            button.selected = YES;
        }
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)buttonClick:(UIButton *)button{
    for (int i = 100; i<105; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        button.selected = NO;
    }
    button.selected = YES;
    if (button.tag == 100) {
        ShowViewController *c = [[ShowViewController alloc] init];
        UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
        [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        //[self.revealSideViewController popViewControllerAnimated:YES];
    }else if (button.tag == 101){
        
        
    }else if (button.tag==102){
        [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
        BOOL isOauth = [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina];
        //如果登陆
        if (isOauth) {
            //我的收藏
            MyCollectionViewController *mcv = [[MyCollectionViewController alloc]init];
            [self.revealSideViewController popViewControllerWithNewCenterController:mcv animated:YES];
        }else{
            //跳出登陆界面
            LoginViewController *lvc = [[LoginViewController alloc]init];
            UINavigationController *n = [[UINavigationController alloc]initWithRootViewController:lvc];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
    }else if (button.tag == 103){
        
        
    }else if (button.tag == 104){
        MoreSettingViewController *msvc = [[MoreSettingViewController alloc]init];
        UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:msvc];
        [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([DeviceManager  currentScreenHeight]==568) {
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg568"]];
    }else{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg480"]];}
    [self createButton];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
