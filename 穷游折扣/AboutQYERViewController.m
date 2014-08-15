//
//  AboutQYERViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "AboutQYERViewController.h"
#import "MyNavigationBar.h"
#import "MoreSettingViewController.h"
#import "DeviceManager.h"

@interface AboutQYERViewController ()

@end

@implementation AboutQYERViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)bbiClick{
    MoreSettingViewController *msvc = [[MoreSettingViewController alloc]init];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:msvc];
    [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
}

- (void)createNavigationBar{
    self.navigationController.navigationBarHidden = YES;
    MyNavigationBar *mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"关于" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_webview_back"] andRigtBBIImageName:nil andClass:self andSEL:@selector(bbiClick)];
    [self.view addSubview:mnb];
}

- (void)createBackgroundImage{
    NSInteger height = [DeviceManager currentScreenHeight];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, height-64)];
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 195)];
    headerImageView.image = [UIImage imageNamed:@"about_text"];
    [view addSubview:headerImageView];

    
    UIImageView *footerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, height-70-64, 320, 70)];
    footerImageView.image = [UIImage imageNamed:@"about_version"];
    [view addSubview:footerImageView];
    
    [self.view addSubview:view];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavigationBar];
    [self createBackgroundImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
