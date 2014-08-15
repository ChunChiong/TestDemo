//
//  TripNodeModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-11.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
//用于存储node
@interface TripNodeModel : NSObject
//nodes下的基本信息
@property (nonatomic, copy) NSString *attraction_type;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *entry_id;
@property (nonatomic, copy) NSString *entry_name;//地点的名字
@property (nonatomic, copy) NSString *entry_type;//用于确定entry的类型
@property (nonatomic, assign) NSInteger nodeID;
@property (nonatomic, assign) CGFloat lat;
@property (nonatomic, assign) CGFloat lng;
@property (nonatomic, strong) NSDictionary *memo;//门票信息
@property (nonatomic, assign) CGFloat score;

@end
