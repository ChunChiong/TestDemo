//
//  CustomTabBar.m
//  NewsProject
//
//  Created by  江志磊 on 14-2-11.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame tabBarDic:(NSDictionary *)dic titles:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {
       //创建tabBar视图
        [self createTabBarWithDic:dic titles:titles];
    }
    return self;
}
- (void)createTabBarWithDic:(NSDictionary *)dic titles:(NSArray *)titles{
    //allKeys 得到的是存有所有key值的数组
    if (dic.allKeys.count == 0) {
        return;
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:label];
    NSArray *imageNames = [dic objectForKey:@"imageName"];
    NSArray *imageNamesH = [dic objectForKey:@"imageNameh"];
    CGFloat btnWidth = self.bounds.size.width/imageNames.count;
    CGFloat btnHeight = 30;
    for (int i = 0; i<imageNames.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(btnWidth*i,31, btnWidth, 10)];
        label.text = titles[i];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*btnWidth,0, btnWidth, btnHeight)];
        [btn setImage:[UIImage imageNamed:[imageNames objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[imageNamesH objectAtIndex:i]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100+i;
        if (i==0) {
            btn.selected = YES;
        }
        [self addSubview:label];
        [self addSubview:btn];
    }
}
- (void)btnClicked:(UIButton *)btn{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *currentBtn = (UIButton *)view;
            if (currentBtn.tag == btn.tag) {
                //找到被选中的按钮
                currentBtn.selected = YES;
            }else{
                currentBtn.selected = NO;
            }
        }
    }
    NSInteger index = btn.tag - 100;
    if ([_delegate respondsToSelector:@selector(customTabBar:didSelectedIndex:)]) {
        [_delegate customTabBar:self didSelectedIndex:index];
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
