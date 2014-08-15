//
//  DeviceManager.m
//  LimitFreeProject
//
//  Created by  江志磊 on 14-6-13.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager


//获取屏幕的高度
+(NSInteger)currentScreenHeight{
   //UIScreen 代表设备屏幕的类,单例
    //获取到屏幕的高度
    return [UIScreen mainScreen].bounds.size.height;
}

//判断操作系统版本是否为ios7
+(BOOL)isIOS7Version{
    //获取到版本号
    NSString *version = [UIDevice currentDevice].systemVersion;
    //6.11 6.13 7.0 7.11
    //hasPrefix 是否具有某前缀
    if ([version hasPrefix:@"7"]) {
        return YES;
    }else{
        return NO;
    }
}

//获取手机的型号
+(NSString *)currentDeviceModel{
   //UIDevice 此类中带有iphone设备的信息(操作系统版本、手机型号、手机的名字)
    return [UIDevice currentDevice].model;
}

@end
