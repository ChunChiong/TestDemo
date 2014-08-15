//
//  LocationModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//旅行地list
#import <Foundation/Foundation.h>

@interface LocationModel : NSObject

@property (nonatomic, assign) NSInteger attraction_trips_count;
@property (nonatomic, copy) NSString *description_summary;
@property (nonatomic, assign) NSInteger locationID;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *user_score;

@end
