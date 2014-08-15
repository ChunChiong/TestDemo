//
//  DapeiViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-11.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "DapeiViewController.h"
#import "MobanLiebiaoViewController.h"
#import "DapeizhidaoViewController.h"

@interface DapeiViewController ()

@end

@implementation DapeiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return self;
}

//隐藏自定义tabBar
- (void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController.view.subviews lastObject] setHidden:YES];
}

//显示自定义TabBar
- (void)viewWillDisappear:(BOOL)animated{
    [[self.tabBarController.view.subviews lastObject] setHidden:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"我的搭配";

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_help_new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(zhidao)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addDapei)];
    self.navigationItem.rightBarButtonItems = @[item2,item1];

}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)zhidao
{
    DapeizhidaoViewController *dv = [[DapeizhidaoViewController alloc] init];
    [self.navigationController pushViewController:dv animated:YES];
    
}

- (void)addDapei
{
    MobanLiebiaoViewController *mv = [[MobanLiebiaoViewController alloc] init];
    [self.navigationController pushViewController:mv animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
