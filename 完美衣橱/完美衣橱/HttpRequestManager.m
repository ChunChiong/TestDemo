//
//  HttpRequestManager.m
//  LimitFreeProject
//
//  Created by  江志磊 on 14-6-13.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import "HttpRequestManager.h"
#import "HttpRequest.h"

@implementation HttpRequestManager{
    //用于维护多个request对象
    //为了区分不用的request对象，用request对应的请求地址(urlString)作为key值:(request-urlString)
    NSMutableDictionary*_requestDic;
}
//单例
static HttpRequestManager *requestmanager = nil;
+(HttpRequestManager *)shareManager{
    if (requestmanager == nil) {
        requestmanager = [[HttpRequestManager alloc] init];
    }
    return  requestmanager;
}
- (id)init{
    self = [super init];
    if (self) {
      //初始化字典
        _requestDic =[[NSMutableDictionary alloc] init];
    }
    return self;
}

//将request对象添加到字典中，key为urlString
- (void)setRequestObject:(id)obj forkey:(NSString *)key{
    if (obj) {
        [_requestDic setObject:obj forKey:key];
    }
}
//移除request对象的方法
- (void)removeRequestForkey:(NSString *)key{
    [_requestDic removeObjectForKey:key];
}

//将request的delegate置空
- (void)clearDelegateForKey:(NSString *)key{
    HttpRequest *request = [_requestDic objectForKey:key];
    //将delegate置为nil
    request.delegate = nil;
}

@end
