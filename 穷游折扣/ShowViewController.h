//
//  ShowViewController.h
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShowCell.h"
#import "SRRefreshView.h"//水滴效果刷新


@interface ShowViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,ShowCellDelegate,SRRefreshDelegate>

@end
