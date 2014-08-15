//
//  LocationViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "RootTableViewController.h"
//旅行地, 其实就是attraction的列表页
@interface LocationViewController : RootTableViewController

@property (nonatomic, assign) NSInteger locationID;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, assign) NSInteger currentPage;

@end
