//
//  CustomTabBar.m
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar {
    //记录当前被选中的button
    NSInteger _currentIndex;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame Dict:(NSDictionary *)dict
{
    if (self = [super initWithFrame:frame]) {
        [self createTabBarWithDict:dict];
    }
    return self;
}

//根据字典信息，创建tabBar
- (void)createTabBarWithDict:(NSDictionary *)dict
{
    NSArray *imgsArray = [dict objectForKey:@"imgs"];
    NSArray *imgSelArray = [dict objectForKey:@"imgSel"];
    NSArray *titleArray = [dict objectForKey:@"title"];
    
    //设置tabbar的背景图
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    [bgView setImage:[UIImage imageNamed:@"TabBarBackground"]];
    bgView.userInteractionEnabled = YES;
    [self addSubview:bgView];
    CGFloat width = 320/[imgsArray count];

    for (int i=0; i<[imgsArray count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, 0, width, 35);
        //设置背景图，以及按钮的图片
        [button setBackgroundImage:[UIImage imageNamed:@"TabBarItemSelected"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:[imgsArray objectAtIndex:i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[imgSelArray objectAtIndex:i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [bgView addSubview:button];

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*i, 35, width, 14)];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.text = [titleArray objectAtIndex:i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
        titleLabel.tag = 200+i;
        [bgView addSubview:titleLabel];
        //使第一个按钮默认被选中
        if (i==0) {
            button.selected = YES;
            _currentIndex = i;
            titleLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBarItemSelected"]];
            titleLabel.textColor = [UIColor whiteColor];
        }
    }
    
}

- (void)buttonClicked:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    //获取当前被选中的按钮，并取消对它的选中
    UIButton *currentBtn = (UIButton *)[self viewWithTag:_currentIndex+100];
    currentBtn.selected = NO;

    //重置label的背景色
    UILabel *currentLabel = (UILabel *)[self viewWithTag:_currentIndex+200];
    currentLabel.backgroundColor = [UIColor clearColor];
    currentLabel.textColor = [UIColor lightGrayColor];
    
    //使被点击按钮被选中
    _currentIndex = index;
    button.selected = YES;
    //设置被选中label的背景色
    UILabel *selectedLabel = (UILabel *)[self viewWithTag:index+200];
    selectedLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TabBarItemSelected"]];
    selectedLabel.textColor = [UIColor whiteColor];
    
    //执行代理方法
    if ([self.delegate respondsToSelector:@selector(CustomTabBarDidSelectedAtIndex:)]) {
        [self.delegate CustomTabBarDidSelectedAtIndex:index];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
