//
//  TravalModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravalModel : NSObject

//@property (nonatomic, assign) NSInteger budget;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, assign) NSInteger travelID;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger plan_days_count;
@property (nonatomic, assign) NSInteger plan_nodes_count;
@property (nonatomic, assign) NSInteger updated_at;
@property (nonatomic, strong) NSDictionary *destination;

@end
