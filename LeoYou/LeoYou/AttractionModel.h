//
//  AttractionModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//旅行地详情的model，因为和list的差别比较大，所以这里就重写了一个model
#import <Foundation/Foundation.h>
@interface AttractionModel : NSObject
@property (nonatomic, assign) NSInteger attrID;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *name_en;
@property (nonatomic, copy) NSString *name_zh_cn;
@end
