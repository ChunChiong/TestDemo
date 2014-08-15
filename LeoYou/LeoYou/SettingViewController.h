//
//  SettingViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-16.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//我的页面的侧滑页面
#import <UIKit/UIKit.h>

@protocol settingViewDelegate <NSObject>
//当用户确定删除
- (void)clearMineSure;

@end
@interface SettingViewController : UIViewController

@property (nonatomic, weak) id<settingViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *cacheSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mineNumLabel;

@end
