//
//  RootViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "RootViewController.h"
#import "CusTabBarViewController.h"
#import "UMSocial.h"

@interface RootViewController () <UIActionSheetDelegate, UMSocialUIDelegate> {
    //显示navigationBar上的titleView
    UILabel *_titleLabel;
}

@end

@implementation RootViewController

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
    //设置默认背景色
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:247/255.0 blue:234/255.0 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationBar"] forBarMetrics:UIBarMetricsDefault];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = _titleLabel;
}

- (void)setCustomTitle:(NSString *)title
{
    _titleLabel.text = title;
}


//隐藏tabBar
- (void)hideCusTabBar
{
    CusTabBarViewController *tbc = (CusTabBarViewController *)self.tabBarController;
    [tbc hideTabBar];
}

//显示tabBar
- (void)showCusTabBar
{
    CusTabBarViewController *tbc = (CusTabBarViewController *)self.tabBarController;
    [tbc showTabBar];
}

- (void)customBackBtn
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 40);
    [backButton setImage:[UIImage imageNamed:@"BackIndicator"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backbuttonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

- (void)backbuttonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 地图呼出按钮
- (void)mapBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:[UIImage imageNamed:@"MapMarkBarIcon"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(mapBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

//在子类中重新此方法
- (void)mapBtnClicked
{

}

#pragma mark 编辑的按钮
- (void)editBtn
{
    [self createRightItemBtnWithImg:@"BarIconEdit" Action:@selector(editBtnClicked)];
}

//在子类中重新此方法
- (void)editBtnClicked
{

}
#pragma mark setting按钮
- (void)settingBtn
{
    [self createRightItemBtnWithImg:@"SettingLeftBarButton" Action:@selector(settingBtnClicked) isLeft:YES];
}
//设置按钮点击，在子类中复写此方法
- (void)settingBtnClicked
{

}


#pragma mark 分享和收藏的按钮
- (void)shareAndSaveBtn
{
    [self createRightItemBtnWithImg:@"MoreIcon" Action:@selector(shareAndSaveBtnClicked)];
}

- (void)shareAndSaveBtnClicked
{
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"分享", @"收藏", nil];
    [as showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self shareWithMessage:nil];
            break;
        case 1:
            [self save];
            break;
    }
}

//在子类中重写此方法，设置message
- (void)shareWithMessage:(NSString *)message
{
    message = message ? message : @"Leo is a good guy";
    [self shareMessageByUM:message];
}

#pragma mark单独的分享按钮
- (void)shareBtn
{
    [self createRightItemBtnWithImg:@"ShareBarButton" Action:@selector(shareBtnClick)];
}

//在子类中重写此方法，设置message
- (void)shareBtnClick
{
    
}

//创建导航栏右按钮的通用方法
- (void)createRightItemBtnWithImg:(NSString *)img Action:(SEL)action
{
    [self createRightItemBtnWithImg:img Action:action isLeft:NO];
}

- (void)createRightItemBtnWithImg:(NSString *)img Action:(SEL)action isLeft:(BOOL) isLeft
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
}


//友盟的分享方法
- (void)shareMessageByUM:(NSString *)message
{
    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"51c164ac56240b1648044f45" shareText:message shareImage:nil shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToDouban,UMShareToEmail,UMShareToSms, nil] delegate:self];
}

- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //do nothing for now
}

//在子类中重写此方法，进行具体的保存事宜
- (void)save
{
    NSLog(@"save");
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置NavigationItem
//Side YES 如果是left No如果是right
- (void)setNavigationItemWithItem:(UIBarButtonItem *)item isLeft:(BOOL)isLeft
{
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
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
