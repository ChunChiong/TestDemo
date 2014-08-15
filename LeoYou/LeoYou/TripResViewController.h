//
//  TripResViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "RootTableViewController.h"

@interface TripResViewController : RootTableViewController

@property (nonatomic, copy) NSString *searchKeyword;

@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isLoadMore;
@property (nonatomic, assign) NSInteger currentPageTrip;

@end
