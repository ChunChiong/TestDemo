//
//  MoreSettingViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "MoreSettingViewController.h"
#import "DeviceManager.h"
#import "MyNavigationBar.h"
#import "CategoryViewController.h"
#import "AboutQYERViewController.h"
#import "SDImageCache.h"
#import "UMSocial.h"
#import "LoginViewController.h"

@interface MoreSettingViewController (){
    UIScrollView *_scrollview;
}

@end

@implementation MoreSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.tabBarController.tabBar.hidden=YES;
        _userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 70, 150, 50)];
        
    }
    return self;
}

- (void)bbiClick{
    //抽屉
    CategoryViewController *left = [[CategoryViewController alloc] init];
    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"detail_remind_btn_highlighted@2x"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBarHidden = YES;
    MyNavigationBar *mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    [mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"我的收藏" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_drawer"] andRigtBBIImageName:nil andClass:self andSEL:@selector(bbiClick)];
    [self.view addSubview:mnb];

    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 120, 44)];
//    label.textAlignment=NSTextAlignmentCenter;
//    label.text=@"更多设置";
//    label.font=[UIFont boldSystemFontOfSize:25];
//    label.textColor=[UIColor whiteColor];
//    self.navigationItem.titleView=label;
    [self creatUI];

}

-(void)creatUI{
    NSInteger heigh=[DeviceManager currentScreenHeight];
    _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320,heigh-64)];
    _scrollview.contentSize=CGSizeMake(320, 600);
    _scrollview.showsVerticalScrollIndicator=NO;
    //    scrollview.bounces=NO;
    _scrollview.backgroundColor=[UIColor colorWithRed:220/255.0f green:220/255.0f blue:220/255.0f alpha:1.0f];
    [self.view addSubview:_scrollview];
    
    
    
    
    NSArray*array=@[@"  基本设置",@"穷游账号",@"分享设置",@"立即更新到最新版本",@"关于穷游折扣"];
    for (int i=0; i<5; i++) {
        
        
        if (i==0) {
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 50)];
            label.text=[array objectAtIndex:0];
            label.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
            label.font=[UIFont systemFontOfSize:20];
            [_scrollview addSubview:label];
            UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 69, 300, 0.5)];
            label1.backgroundColor=[UIColor blackColor];
            label1.alpha=0.3;
            [_scrollview addSubview:label1];
            
        }else{
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame=CGRectMake(10, 20+50*i, 300, 50);
            [button setBackgroundColor:[UIColor whiteColor]];
            button.backgroundColor=[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
            button.tag=100+i;
            [button addTarget:self action:@selector(bbiClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollview addSubview:button];
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 20+5+50*i, 200, 40)];
            label.text=[array objectAtIndex:i];
            
            label.textColor=[UIColor blackColor];
            label.font=[UIFont systemFontOfSize:20];
            [_scrollview addSubview:label];
            if (i!=4) {
                UIImageView*imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(270, 20+50*i+5, 30, 40)];
                imageview3.image=[UIImage imageNamed:@"arrowNew"];
                [_scrollview addSubview:imageview3];
                UIImageView*imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(30, 20+50*i+49, 260, 1)];
                imageview2.image=[UIImage imageNamed:@"best_line@2x"];
                [_scrollview addSubview:imageview2];
            }
            if (i==1) {
                [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
                NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
                UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
                NSString *loginName = sinaAccount.userName;
                if (loginName) {
                    _userNameLabel.text = loginName;
                }
                else{
                    _userNameLabel.text = @"请登录";
                    
                }
                _userNameLabel.textAlignment = NSTextAlignmentRight;
                [_scrollview addSubview:_userNameLabel];

                
            }
            
        }
        
    }
    
    UILabel*label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 280, 300, 50)];
    label2.text=@"  功能设置";
    label2.font=[UIFont systemFontOfSize:20];
    label2.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
    [_scrollview addSubview:label2];
    UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 329, 300, 1)];
    label1.backgroundColor=[UIColor blackColor];
    label1.alpha=0.3;
    [_scrollview addSubview:label1];
    
    
    UIButton*button1=[UIButton buttonWithType:UIButtonTypeCustom];
    
    button1.frame=CGRectMake(10, 330, 300, 50);
    [button1 setBackgroundColor:[UIColor whiteColor]];
    button1.backgroundColor=[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
    button1.tag=105;
    [button1 addTarget:self action:@selector(bbiClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollview addSubview:button1];
    UILabel*label3=[[UILabel alloc]initWithFrame:CGRectMake(20, 335, 200, 40)];
    label3.text=@"清空缓存";
    
    label3.textColor=[UIColor blackColor];
    label3.font=[UIFont systemFontOfSize:20];
    [_scrollview addSubview:label3];
    [self creatLastButton];
    
}
-(void)creatLastButton{
    NSArray *array=@[@"  其它",@"意见反馈",@"评价我们",@"分享应用"];
    for (int i=0; i<4; i++) {
        
        
        if (i==0) {
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 390, 300, 50)];
            label.text=[array objectAtIndex:0];
            label.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1.0f];
            label.font=[UIFont systemFontOfSize:20];
            [_scrollview addSubview:label];
            UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 69+370, 300, 0.5)];
            label1.backgroundColor=[UIColor blackColor];
            label1.alpha=0.3;
            [_scrollview addSubview:label1];
            
        }else{
            UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
            
            button.frame=CGRectMake(10, 390+50*i, 300, 50);
            [button setBackgroundColor:[UIColor whiteColor]];
            button.backgroundColor=[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f];
            button.tag=105+i;
            [button addTarget:self action:@selector(bbiClick:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollview addSubview:button];
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(20, 390+5+50*i, 200, 40)];
            label.text=[array objectAtIndex:i];
            
            label.textColor=[UIColor blackColor];
            label.font=[UIFont systemFontOfSize:20];
            [_scrollview addSubview:label];
            if (i!=4) {
                UIImageView*imageview3=[[UIImageView alloc]initWithFrame:CGRectMake(270, 390+50*i+5, 30, 40)];
                imageview3.image=[UIImage imageNamed:@"arrowNew"];
                [_scrollview addSubview:imageview3];
                UIImageView*imageview2=[[UIImageView alloc]initWithFrame:CGRectMake(30, 390+50*i+49, 260, 1)];
                imageview2.image=[UIImage imageNamed:@"best_line@2x"];
                [_scrollview addSubview:imageview2];
            }
            
            
        }
        
    }
}
-(void)bbiClick:(UIButton*)button{
    if (button.tag==101) {
        [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
        BOOL isOauth = [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina];
        if (isOauth) {
            [[UMSocialDataService defaultDataService] requestUnOauthWithType:UMShareToSina  completion:^(UMSocialResponseEntity *response){
                _userNameLabel.text = @"请登录";
            }];
        } else {
            LoginViewController *lvc = [[LoginViewController alloc]init];
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:lvc];
            [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
        }
        
    }else if (button.tag==104) {
        AboutQYERViewController *aqyervc = [[AboutQYERViewController alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:aqyervc];
        [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
    }else if (button.tag==105){
        [self clearTmpPics];
    }
}

//清除缓存
- (void)clearTmpPics
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       NSLog(@"files :%d",[files count]);
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});

}

-(void)clearCacheSuccess
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"清除成功" message:@"清除缓存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
