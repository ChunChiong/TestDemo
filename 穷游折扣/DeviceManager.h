//
//  DeviceManager.h
//  LimitFreeProject
//
//  Created by  江志磊 on 14-6-13.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import <Foundation/Foundation.h>
//里面封装了获取设备信息的方法
@interface DeviceManager : NSObject

//获取屏幕的高度
+(NSInteger)currentScreenHeight;

//判断操作系统版本是否为ios7
+(BOOL)isIOS7Version;

//获取手机的型号
+(NSString *)currentDeviceModel;

@end
