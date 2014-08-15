//
//  RootGroupTableViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "RootViewController.h"

@interface RootGroupTableViewController : RootViewController<UITableViewDataSource, UITableViewDelegate>
//tableView
@property (nonatomic, strong) UITableView *tableView;
//数据源数据
@property (nonatomic, strong) NSMutableArray *dataArray;

@end
