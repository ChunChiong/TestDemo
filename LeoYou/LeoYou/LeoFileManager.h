//
//  LeoFileManager.h
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//一些关于文件的基本操作
#import <Foundation/Foundation.h>

@interface LeoFileManager : NSObject
+ (id)shareManager;

//创建文件夹，文件夹如果存在，就不在创建
- (void)createDictWithPath:(NSString *)path;
//获取当前文件的创建时间
- (NSTimeInterval)createTimeOfFile:(NSString *)file;
//清空文件夹
- (void)clearDictWithPath:(NSString *)path;
//获得一个文件夹的大小
- (NSString *)getSizeOfDir:(NSString *)path;


@end
