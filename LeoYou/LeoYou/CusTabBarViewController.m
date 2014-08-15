//
//  CusTabBarViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "CusTabBarViewController.h"
#import "RootViewController.h"
#import "PPRevealSideViewController.h"

@interface CusTabBarViewController () {
    CustomTabBar *_cusTabBar;
}

@end

@implementation CusTabBarViewController

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
    [self createControllers];
    [self createTabBar];
    
}

//设置视图控制器
- (void)createControllers
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBar" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *controllersName = [dict objectForKey:@"viewControllers"];
    NSMutableArray *controllers = [[NSMutableArray alloc] initWithCapacity:[dict count]];
    int i = 0;
    for (NSString *controller in controllersName) {
        Class cls = NSClassFromString(controller);
        RootViewController *vc = [[cls alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if (i==2) {
            PPRevealSideViewController *pp = [[PPRevealSideViewController alloc] initWithRootViewController:nav];
            [controllers addObject:pp];
        } else {
            [controllers addObject:nav];
        }
        i++;
    }
    self.viewControllers = controllers;
}

//创建视图
- (void)createTabBar
{
    self.tabBar.hidden = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TabBar" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    _cusTabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, [DeviceManager  screenHeight]-49, 320, 49) Dict:dict];
    _cusTabBar.delegate = self;
    [self.view addSubview:_cusTabBar];
}

//隐藏tabBar
- (void)hideTabBar
{
    _cusTabBar.hidden = YES;
}

//显示tabBar
- (void)showTabBar
{
    _cusTabBar.hidden = NO;
}

#pragma mark CustomTabBar delegate
- (void)CustomTabBarDidSelectedAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
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
