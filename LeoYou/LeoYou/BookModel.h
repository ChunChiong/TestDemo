//
//  BookModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
//口袋书的模型
@interface BookModel : NSObject

@property (nonatomic, assign) NSInteger articles_count;//专题数
@property (nonatomic, assign) NSInteger contents_count;
@property (nonatomic, assign) NSInteger destination_trips_count;//游记数
@property (nonatomic, assign) NSInteger guides_count;
@property (nonatomic, assign) NSInteger bookID;
@property (nonatomic, copy) NSString *image_url;//图片
@property (nonatomic, copy) NSString *name_en;//英文名
@property (nonatomic, copy) NSString *name_zh_cn;//中文名
@property (nonatomic, assign) NSInteger plans_count;//行程数
@property (nonatomic, assign) NSInteger poi_count;//旅行地
@property (nonatomic, assign) NSInteger updated_at;


@end
