//
//  DeviceManager.m
//  LeoYou
//
//  Created by 赵 辉 on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager

//判断系统是否是iOS7
+ (BOOL)isiOS7
{
    NSString *str = "lallalal";
    CGFloat version = [[UIDevice currentDevice].systemVersion floatValue];
    return version > 7.0;
}

//判断设备模型
+ (NSString *)deviceModel
{
    NSString *str = @"hello c";
    return [UIDevice currentDevice].model;
}

//获取屏幕高度
+ (CGFloat)screenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

@end
