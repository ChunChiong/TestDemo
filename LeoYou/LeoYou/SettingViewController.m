//
//  SettingViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-16.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "SettingViewController.h"
#import "DBManager.h"
#import "LeoFileManager.h"

@interface SettingViewController () <UIAlertViewDelegate>

@end

@implementation SettingViewController

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
    // Do any additional setup after loading the view from its nib.
    self.cacheSizeLabel.text = [self getCacheSize];
    self.mineNumLabel.text = [NSString stringWithFormat:@"%d篇", [[DBManager sharedManger] getNumOfTrip]];
}

- (NSString *)getCacheSize
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:kCachePath];
    return [[LeoFileManager shareManager] getSizeOfDir:path];
}


//去评分按钮点击时
- (IBAction)settingBtnClicked:(id)sender {
    NSString *m_appleID = @"leo.com.Chanyouji";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/tw/app/id%@",m_appleID]]];
}
//访问我们的网站被点击时
- (IBAction)visitUsBtnClicked:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://chanyouji.com"]];
}
//清除我的收藏被点击时
- (IBAction)clearMineClicked:(id)sender {
    if ([[DBManager sharedManger] getNumOfTrip] > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"..." message:@"确定删除收藏的游记？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 100;
        [alert show];
    } else {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"..." message:@"你还未收藏任何游记" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
        [alert show];
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case 100://清除收藏
        {
            if (buttonIndex == 1) {
                [[DBManager sharedManger] clearAllTrip];
                if ([self.delegate respondsToSelector:@selector(clearMineSure)]) {
                    [self.delegate clearMineSure];
                }
                self.mineNumLabel.text = [NSString stringWithFormat:@"0篇", [[DBManager sharedManger] getNumOfTrip]];
            }
        }
            break;
        case 101://清除缓存
        {
            if (buttonIndex == 1) {
                NSString *path = [NSHomeDirectory() stringByAppendingString:kCachePath];
                [[LeoFileManager shareManager] clearDictWithPath:path];
                self.cacheSizeLabel.text = @"0M";
            }
        }
            
        default:
            break;
    }

}

//清除缓存被点击时
- (IBAction)clearCachedClicked:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"..." message:@"确定删除所有缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
