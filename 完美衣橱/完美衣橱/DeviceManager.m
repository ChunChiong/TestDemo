//
//  DeviceManager.m
//  NewsProject
//
//  Created by  江志磊 on 14-2-11.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import "DeviceManager.h"

@implementation DeviceManager

+ (NSInteger)currentScreenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)isIos7Version{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if ([version hasPrefix:@"7"]) {
        return YES;
    }
    return NO;
}
//设备的类型
+ (NSString *)currentDeviceModel{
    return [UIDevice currentDevice].model;
}

@end
