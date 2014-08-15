//
//  RootTableViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "RootViewController.h"
//所有带有tabview的vc的父类
@interface RootTableViewController : RootViewController <UITableViewDataSource, UITableViewDelegate>
//tableView
@property (nonatomic, strong) UITableView *tableView;
//数据源数据
@property (nonatomic, strong) NSMutableArray *dataArray;
//tableView类型是否为group
@property (nonatomic, assign) BOOL isGroup;
@end
