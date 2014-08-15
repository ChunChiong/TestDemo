//
//  CusTabBarViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"

@interface CusTabBarViewController : UITabBarController <CustomTabBarDelegate>
//隐藏tabBar
- (void)hideTabBar;
//显示tabBar
- (void)showTabBar;
@end
