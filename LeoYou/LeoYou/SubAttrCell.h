//
//  SubAttrCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//用于旅行地详情中每个cell
#import <UIKit/UIKit.h>
#import "ImgScrollView.h"

@interface SubAttrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *attrDesLabel;
@property (weak, nonatomic) IBOutlet ImgScrollView *attrScrollView;
@property (weak, nonatomic) IBOutlet UILabel *attrDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *attrBottomLine;

@end
