//
//  CustomTabBarController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "CustomTabBarController.h"
#import "ParentsViewController.h"
#import "DeviceManager.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

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
    [self cresteTabBar];
}

- (void)createControllers
{
    NSArray *array = @[@"SimiViewController",@"ZhuyeViewController",@"GuanzhuViewController",@"GuangchangViewController",@"MoreViewController"];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];

    for (int i = 0; i<array.count; i++) {
        Class cls = NSClassFromString(array[i]);
        ParentsViewController *pv = [[cls alloc] init];
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:pv];
            [controllers addObject:nv];
        
        }
    self.viewControllers = controllers;
}

- (void)cresteTabBar
{
    self.tabBar.hidden = YES;
    NSArray *titles = @[@"私密",@"主页",@"关注",@"广场",@"更多"];
    
    NSArray *images = @[@"tab_mine",@"tab_upload",@"tab_attention",@"tab_square",@"tab_user"];
    NSArray *selectedImages = @[@"tab_mine_pressed",@"tab_upload_pressed",@"tab_attention_pressed",@"tab_square_pressed",@"tab_user_pressed"];
    
    NSDictionary *dict = @{@"imageName": images,@"imageNameh":selectedImages};
    
    CustomTabBar *tabBar = [[CustomTabBar alloc] initWithFrame:CGRectMake(0, [DeviceManager currentScreenHeight]-44, 320, 44) tabBarDic:dict titles:titles];
    tabBar.delegate = self;
    [self.view addSubview:tabBar];
    
}


- (void)customTabBar:(CustomTabBar *)tabBar didSelectedIndex:(NSInteger)index
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
