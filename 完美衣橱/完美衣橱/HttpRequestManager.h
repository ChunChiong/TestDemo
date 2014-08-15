//
//  HttpRequestManager.h
//  LimitFreeProject
//
//  Created by  江志磊 on 14-6-13.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import <Foundation/Foundation.h>
//请求管理类：用于维护多个request对象的生命周期
@interface HttpRequestManager : NSObject
//manager的生命周期，与工程一致(单例)
//返回单例对象
+(HttpRequestManager *)shareManager;
//将request对象添加到字典中，key为urlString
- (void)setRequestObject:(id)obj forkey:(NSString *)key;
//移除request对象的方法
- (void)removeRequestForkey:(NSString *)key;
//将request的delegate置空
- (void)clearDelegateForKey:(NSString *)key;
@end
