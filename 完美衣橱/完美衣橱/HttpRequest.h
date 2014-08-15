//
//  HttpRequest.h
//  LimitFreeProject
//
//  Created by  江志磊 on 14-6-13.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpRequest;
@protocol HttpRequestDelegate <NSObject>
//数据请求完成
- (void)httpRequestFinished:(HttpRequest *)request;
- (void)httpRequestFailed:(HttpRequest *)request;

@end

//负责客户端和服务端的交互(每个request对应一个接口)
@interface HttpRequest : NSObject<NSURLConnectionDataDelegate>
//接口(请求地址)
@property (nonatomic,copy) NSString *requestString;
//数据,提供给vc使用
@property (nonatomic,retain) NSMutableData *downloadData;
//delegate 赋值为vc
@property (nonatomic,assign) id<HttpRequestDelegate>delegate;
//用于标识不同类型的request
@property (nonatomic,copy) NSString *apiType;
//暴露给外部一个类方法,向服务端请求数据
//requestString 请求地址  delegate 要赋值成不同的vc对象
+(HttpRequest *)requestWithUrlString:(NSString *)requestString target:(id<HttpRequestDelegate>)delegate;



@end
