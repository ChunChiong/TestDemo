//
//  CustomTabBar.h
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
//封装自定义tabBar的视图
@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>
//当某个TabBarItem被选中后，执行的方法
- (void)CustomTabBarDidSelectedAtIndex:(NSInteger)index;

@end


@interface CustomTabBar : UIView

@property (nonatomic, weak) id<CustomTabBarDelegate> delegate;
- (id)initWithFrame:(CGRect)frame Dict:(NSDictionary *)dict;
@end
