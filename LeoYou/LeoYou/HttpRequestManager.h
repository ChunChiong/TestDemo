//
//  HttpRequestManager.h
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"


@protocol HttpRequestManagerDelegate <NSObject>

- (void)httpLoadDataSuccess:(id)data;
- (void)httpLoadDataFailed:(NSString *)error;


@end

//仍然使用AFNetWorking,这里重写是为了缓存一部分数据
@interface HttpRequestManager : NSObject

@property (nonatomic, weak) id<HttpRequestManagerDelegate>delegate;

- (void)requestDataWithURLStr:(NSString *)urlStr;

@end
