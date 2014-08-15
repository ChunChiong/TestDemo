//
//  AttractionViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

//显示旅行地详情页
#import "RootTableViewController.h"
#import "LocationModel.h"

@interface AttractionViewController : RootTableViewController

@property (nonatomic, assign) NSInteger locationID;//基本信息
@property (nonatomic, copy) NSString *locationName;

@end
