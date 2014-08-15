//
//  DeviceManager.h
//  LeoYou
//
//  Created by 赵 辉 on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceManager : NSObject

//判断系统是否是iOS7
+ (BOOL)isiOS7;
//判断设备模型
+ (NSString *)deviceModel;
//获取屏幕高度
+ (CGFloat)screenHeight;

@end
