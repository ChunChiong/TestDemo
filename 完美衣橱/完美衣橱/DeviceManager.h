//
//  DeviceManager.h
//  NewsProject
//
//  Created by  江志磊 on 14-2-11.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import <Foundation/Foundation.h>
//通用函数写在此类（获取屏幕高度、设备型号，版本号等）
@interface DeviceManager : NSObject

+ (NSInteger)currentScreenHeight;

+ (BOOL)isIos7Version;
//设备的类型
+ (NSString *)currentDeviceModel;

@end
