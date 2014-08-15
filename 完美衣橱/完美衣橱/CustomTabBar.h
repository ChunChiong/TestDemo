//
//  CustomTabBar.h
//  NewsProject
//
//  Created by  江志磊 on 14-2-11.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import <UIKit/UIKit.h>
//视图的封装 参考UIKit中视图的封装思想,将与外部交互的内容，动作等，定义成delegate方法，供外部使用
@class CustomTabBar;
@protocol CustomTabBarDelegate <NSObject>
//告知外部，选中的是哪个按钮
- (void)customTabBar:(CustomTabBar *)tabBar didSelectedIndex:(NSInteger)index;
@end
//自定义的标签栏
@interface CustomTabBar : UIView
//非arc 用assgin  arc 用weak
@property (nonatomic,weak) id <CustomTabBarDelegate>delegate;
//扩展init方法，初始化的时候，接收字典
- (id)initWithFrame:(CGRect)frame tabBarDic:(NSDictionary *)dic titles:(NSArray *)titles;

@end
