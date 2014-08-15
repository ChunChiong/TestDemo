//
//  SubAttractionModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//attraction详情的model
#import <Foundation/Foundation.h>

@interface SubAttractionModel : NSObject
@property (nonatomic, copy) NSString *description;
/*
 {
 "description" : "远观金阁寺",
 "height" : 1061,
 "id" : 3684737,
 "photo_url" : "http://cyj.qiniudn.com/93844/1388465784109p18d3et14i1hd8f428fedmv2223o.jpg",
 "video_url" : null,
 "width" : 1600
 },
 */
@property (nonatomic, strong) NSArray *notes;//这里简化了，数组里存的是图片的信息,结构如上
@property (nonatomic, assign) NSInteger updated_at;
//获取description专用的高度
- (CGFloat)getDescriptionHeight;
//将时间戳转化为可用的日期字符串
- (NSString *)getDateStr;
@end
