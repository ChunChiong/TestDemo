//
//  FeaturedViewController.h
//  LeoYou
//
//  Created by 赵 辉 on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "RootTableViewController.h"
#import "HttpRequestManager.h"

@interface FeaturedViewController : RootTableViewController <HttpRequestManagerDelegate>

@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, strong) UISegmentedControl *seg;
@property (nonatomic, assign) NSInteger currentPageTrip;
@property (nonatomic, assign) NSInteger currentPageSub;
@property (nonatomic, assign) BOOL isSegIndexChanged;

@end
