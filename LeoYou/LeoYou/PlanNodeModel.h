//
//  PlanNodeModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//plannode的模型
#import <Foundation/Foundation.h>

@interface PlanNodeModel : NSObject

@property (nonatomic, copy) NSString *attraction_type;
@property (nonatomic, strong) NSDictionary *destination;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, assign) NSInteger entry_id;
@property (nonatomic, copy) NSString *entry_name;
@property (nonatomic, copy) NSString *entry_type;
@property (nonatomic, assign) NSInteger planID;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy) NSString *tips;
@property (nonatomic, assign) BOOL user_entry;
//获得tips所需的高度
- (CGFloat)getTipsHeight;

@end
