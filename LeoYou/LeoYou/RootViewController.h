//
//  RootViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
//所有vc的父类
@interface RootViewController : UIViewController

//设置NavigationItem
//Side YES 如果是left No如果是right
- (void)setNavigationItemWithItem:(UIBarButtonItem *)item isLeft:(BOOL)isLeft;
- (void)setCustomTitle:(NSString *)title;

//隐藏tabBar
- (void)hideCusTabBar;
//显示tabBar
- (void)showCusTabBar;
- (void)customBackBtn;

//设置分享和收藏按钮
- (void)shareAndSaveBtn;
- (void)shareWithMessage:(NSString *)message;
- (void)shareMessageByUM:(NSString *)message;
- (void)save;
- (void)shareAndSaveBtnClicked;
//打开地图按钮
- (void)mapBtn;
//编辑的按钮
- (void)editBtn;
- (void)editBtnClicked;
//单独的分享按钮
- (void)shareBtn;
- (void)shareBtnClick;

//设置按钮
- (void)settingBtn;
- (void)settingBtnClicked;



@end
