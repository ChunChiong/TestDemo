//
//  MyNavigationBar.m
//  MyNavigationController
//
//  Created by Visitor on 14-4-27.
//  Copyright (c) 2014年 Visitor. All rights reserved.
//

#import "MyNavigationBar.h"

@implementation MyNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)createMyNavigationBarWithBackgroundImageName:(NSString *)backgroundImageName andTitle:(NSString *)title andTitleImageName:(NSString *)titleImageName andLeftBBIImageName:(NSArray *)leftBBIImageName andRigtBBIImageName:(NSArray *)rightBBIImageName andClass:(id)classObject andSEL:(SEL)sel
{
    // 创建背景图
    [self createBackGroundViewWithImageName:backgroundImageName];
    
    // 创建标题
    if(title.length > 0)
    {
        // 有标题文字
        [self createTitleLabelWithTitle:title];
    }
    else
    {
        // 有图片
        [self createTitleViewWithImageName:titleImageName];
    }
    
    // 创建按钮
    if(leftBBIImageName.count > 0)
        [self createBBIWithImageName:leftBBIImageName andIsLeft:YES andClass:classObject andSEL:sel];
    if(rightBBIImageName.count > 0)
        [self createBBIWithImageName:rightBBIImageName andIsLeft:NO andClass:classObject andSEL:sel];
}

- (void)createBackGroundViewWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
}

- (void)createTitleLabelWithTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 23, 320, 26);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:24];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
}

- (void)createTitleViewWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y+18, self.bounds.size.width, self.bounds.size.height-26);
    // 设置图片内容模式为居中
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
}

- (void)createBBIWithImageName:(NSArray *)imageNames andIsLeft:(BOOL)isLeft andClass:(id)classObject andSEL:(SEL)sel
{
    int i=0;
    int j=0;
    for (NSString *imageName in imageNames) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:imageName];
        if(isLeft)
        {
            // 左侧按钮
            btn.frame = CGRectMake(10+i*40, (self.frame.size.height-image.size.height)/2+5, image.size.width, image.size.height);
            btn.tag = j+200;
            
        }
        else
        {
            // 右侧按钮
            btn.frame = CGRectMake(self.frame.size.width-image.size.width-10-i*40, (self.frame.size.height-image.size.height)/2+5, image.size.width, image.size.height);
            btn.tag = j+300;
        }
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        [btn addTarget:classObject action:sel forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        i++;
        j++;
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
