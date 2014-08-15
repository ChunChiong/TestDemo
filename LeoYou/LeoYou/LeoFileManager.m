//
//  LeoFileManager.m
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "LeoFileManager.h"

@implementation LeoFileManager

+ (id)shareManager
{
    static LeoFileManager *manager = nil;
    if (manager == nil) {
        manager = [[LeoFileManager alloc] init];
    }
    return manager;
}

- (void)createDictWithPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDict = YES;
    if (![fm fileExistsAtPath:path isDirectory:&isDict]) {
        [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        NSLog(@"creat file at path %@",path);
    }
}

- (NSTimeInterval)createTimeOfFile:(NSString *)file
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:file]) {
        NSDictionary *info = [fm attributesOfItemAtPath:file error:nil];
        NSDate *current = [info objectForKey:NSFileModificationDate];
        NSDate *date = [NSDate date];
        return [current timeIntervalSinceDate:date];
    } else {
        return 0;
    }
}

- (void)clearDictWithPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    for (NSString *file in [fm contentsOfDirectoryAtPath:path error:nil]) {
        [fm removeItemAtPath:[NSString stringWithFormat:@"%@/%@", path, file] error:nil];
    }
}

- (NSString *)getSizeOfDir:(NSString *)path;
{
    NSFileManager *fm = [NSFileManager defaultManager];
    long long size = 0;
    if ([fm fileExistsAtPath:path]) {
        for (NSString *file in [fm contentsOfDirectoryAtPath:path error:nil]) {
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", path, file];
            NSDictionary *info = [fm attributesOfItemAtPath:filePath error:nil];
            size += [info fileSize];
        }
        return [NSString stringWithFormat:@"%.2fM", (float)size/1024/1024];
    } else {
        return @"0M";
    }
}

@end
