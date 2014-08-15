//
//  LoginViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "LoginViewController.h"
#import "MyNavigationBar.h"
#import "ShowViewController.h"
#import "MyCollectionViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)bbiClick{
    ShowViewController *svc = [[ShowViewController alloc]init];
    UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:svc];
    [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
}

- (void)createNaviBar{
    self.navigationController.navigationBarHidden = YES;
    MyNavigationBar *mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"登陆" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_webview_back"] andRigtBBIImageName:nil andClass:self andSEL:@selector(bbiClick)];
    [self.view addSubview:mnb];
}

- (void)createButton{
    //btn_login_weibo_pressed@2x
    //240*47
    UIButton *weiboLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    weiboLoginButton.frame = CGRectMake(40, 200, 240, 47);
    [weiboLoginButton setImage:[UIImage imageNamed:@"btn_login_weibo_pressed"] forState:UIControlStateNormal];
    [weiboLoginButton addTarget:self action:@selector(weiboLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weiboLoginButton];
}

- (void)weiboLogin{
    [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        MyCollectionViewController *mcvc = [[MyCollectionViewController alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:mcvc];
        [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
    });

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNaviBar];
    [self createButton];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
