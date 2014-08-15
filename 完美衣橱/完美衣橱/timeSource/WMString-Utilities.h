//
//  WMString-Utilities.h
//  Wonderful Moment
//
//  Created by cclv on 11/9/09.
//  Copyright 2009 Ucayee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (WMString_Utilities)

/*!
 @function   string2Date:
 @abstract   Change given string to NSDate
 @discussion If the given str is wrong, should return the current system date
 @param      dateStr A string include the date like "2009-11-09 11:14:41"
 @result     The NSDate object with given format
 */

+ (NSDate *)string2Date:(NSString *)dateStr;

/*!
 @function   stringFromCurrent:
 @abstract   Change given date string to "xxx ago" format
 @discussion If the given str is wrong, should return the current date
 @param      dateStr A string include the date like "2009-11-09 11:14:41" at least 10 characters
 @result     The string with "xxx ago", xxx: years, months, days, hours, minutes, seconds
 */
+ (NSString *)stringFromCurrent:(NSString *)dateStr;

//时间戳转化为时间字符串
+(NSString*)timeStamp:(NSString *)stamp;

@end
