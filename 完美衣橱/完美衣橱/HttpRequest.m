//
//  HttpRequest.m
//  LimitFreeProject
//
//  Created by  江志磊 on 14-6-13.
//  Copyright (c) 2014年  江 志磊. All rights reserved.
//

#import "HttpRequest.h"
#import "HttpRequestManager.h"

@implementation HttpRequest{
    //用于与服务器进行交互
    NSURLConnection *_urlConnection;
}

//重写init方法，进行必要的初始化操作
- (id)init{
    self = [super init];
    if (self) {
        _downloadData = [[NSMutableData alloc] init];
    }
    return self;
}

//发起数据请求
- (void)startRequest{
    NSURL *url = [NSURL URLWithString:_requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    
}

+(HttpRequest *)requestWithUrlString:(NSString *)requestString target:(id<HttpRequestDelegate>)delegate{
    HttpRequest *request = [[[HttpRequest alloc] init] autorelease];
    request.requestString = requestString;
    request.delegate = delegate;
    [request startRequest];
    
    [[HttpRequestManager shareManager] setRequestObject:request forkey:requestString];
    return request;

}



#pragma mark - url connection data delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_downloadData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_downloadData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
     //让vc（delegate）执行后续的操作
    //将downloadData写入本地
   
    if ([_delegate respondsToSelector:@selector(httpRequestFinished:)]) {
        [_delegate httpRequestFinished:self];
    }
    //request对象使命已经完成，通过manager来移除request
    [[HttpRequestManager shareManager] removeRequestForkey:_requestString];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //错误信息
    NSLog(@"error:%@",[error localizedDescription]);
    if ([_delegate respondsToSelector:@selector(httpRequestFailed:)]) {
        [_delegate httpRequestFailed:self];
    }
}


@end
