//
//  LeoDateManager.h
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//主要是对日期的处理
#import <Foundation/Foundation.h>

@interface LeoDateManager : NSObject

//通过一个时间的字符串和时间,差返回一个规定格式的时间
//interval,时间差
//dateStr,时间的字符串 2014-7-17
//currentFormat,dateStr的格式，上面就应该是yyyy-M-dd
//toFormat,想要输出的格式
+ (NSString *)dateStringWithInterVal:(NSTimeInterval)interval sinceDateStr:(NSString*)dateStr inFormat:(NSString *)currentFormat toStrWithFormat:(NSString *)toFormat;


@end
