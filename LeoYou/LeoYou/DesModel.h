//
//  DesModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
//目的地的模型
@interface DesModel : NSObject

@property (nonatomic, assign) NSInteger desID;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, copy) NSString *name_en;
@property (nonatomic, copy) NSString *name_zh_cn;
@property (nonatomic, assign) NSInteger poi_count;
@property (nonatomic, assign) NSInteger updated_at;

@end
