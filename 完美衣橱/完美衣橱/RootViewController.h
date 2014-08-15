//
//  RootViewController.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "ParentsViewController.h"

@interface RootViewController : ParentsViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
}

@end
