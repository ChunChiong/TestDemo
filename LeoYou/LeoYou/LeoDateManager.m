//
//  LeoDateManager.m
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "LeoDateManager.h"

@implementation LeoDateManager

+ (NSString *)dateStringWithInterVal:(NSTimeInterval)interval sinceDateStr:(NSString*)dateStr inFormat:(NSString *)currentFormat toStrWithFormat:(NSString *)toFormat
{
    //将当前的字符串转换为时间
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    inputFormat.dateFormat = currentFormat;
    NSDate *inputDate = [inputFormat dateFromString:dateStr];
    
    //获取当前系统的时间差
    NSTimeZone *zone = [[NSTimeZone alloc] init];
    NSInteger zoneSecond = [zone secondsFromGMT];
    
    //得到经过时间时间差后的日期
    NSDate *outDate = [NSDate dateWithTimeInterval:zoneSecond + interval sinceDate:inputDate];
    //将日期转化为想要的时间格式
    NSDateFormatter *outFormat = [[NSDateFormatter alloc] init];
    outFormat.dateFormat = toFormat;
    return [outFormat stringFromDate:outDate];
}


@end
