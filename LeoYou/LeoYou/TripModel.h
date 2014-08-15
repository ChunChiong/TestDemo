//
//  TripModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TripModel : NSObject

@property (nonatomic, assign) NSInteger comments_count;
//行程天数
@property (nonatomic, assign) NSInteger days;
@property (nonatomic, copy) NSString *end_date;
@property (nonatomic, assign) BOOL featured;
@property (nonatomic, copy) NSString *front_cover_photo_url;
//原来是id,为了避免关键字改为id
@property (nonatomic, assign) NSInteger tripID;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) NSInteger likes_count;
//标题
@property (nonatomic, copy) NSString *name;
//照片数量
@property (nonatomic, assign) NSInteger photos_count;

@property (nonatomic, assign) NSInteger serial_id;
@property (nonatomic, assign) NSInteger serial_position;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *start_date;
/*
"user" : {
"id" : 11316,
"image" : "http://tp2.sinaimg.cn/1740848101/180/40050811429/0",
"name" : "Melody_wingwing"
}
 */
@property (nonatomic, strong) NSDictionary *user;

@property (nonatomic, assign) NSInteger views_count;

@end
