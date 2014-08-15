//
//  HttpRequestManager.m
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "HttpRequestManager.h"
#import "NSString+Hashing.h"
#import "SVProgressHUD.h"
#import "LeoFileManager.h"

@implementation HttpRequestManager

- (void)requestDataWithURLStr:(NSString *)urlStr
{
    NSString *filePath = [self hashPathStr:urlStr];
    //NSLog(@"hhh%d cachefilePaht %@ useCache %d", [self isCachePast:filePath], filePath, kUserCache);
    if (kUserCache && ![self isCachePast:filePath]) {
        NSLog(@"from cache");
        id resultData = [[NSKeyedUnarchiver unarchiveObjectWithFile:filePath] copy];
        if ([self.delegate respondsToSelector:@selector(httpLoadDataSuccess:)]) {
            //NSLog(@"%@", resultData);
            [self.delegate httpLoadDataSuccess:resultData];
        }
        [SVProgressHUD dismiss];
    } else {
        NSLog(@"from interneting");
        AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
        [manger GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"%@", responseObject);
            [NSKeyedArchiver archiveRootObject:responseObject toFile:filePath];
            if ([self.delegate respondsToSelector:@selector(httpLoadDataSuccess:)]) {
                [self.delegate httpLoadDataSuccess:responseObject];
            }
            [SVProgressHUD dismiss];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([self.delegate respondsToSelector:@selector(httpLoadDataFailed:)]) {
                [self.delegate httpLoadDataFailed:error.localizedDescription];
            }
            [SVProgressHUD dismiss];
        }];
    }
}

//判断缓存是否过期
- (BOOL)isCachePast:(NSString *)path
{
    NSTimeInterval currentTime = [[LeoFileManager shareManager] createTimeOfFile:path];
    if (currentTime>kURLCacheTime || currentTime == 0) {
        //超时
        return YES;
    }else{
        return NO;
    }
}

- (NSString *)hashPathStr:(NSString *)str
{
    NSString *dictPath = [NSHomeDirectory() stringByAppendingString:kCachePath];
    [[LeoFileManager shareManager] createDictWithPath:dictPath];
    return [NSString stringWithFormat:@"%@/%@", dictPath, [str MD5Hash]];

}

@end
