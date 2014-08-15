//
//  PlanNodeCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanNodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *planDayIcon;

@property (weak, nonatomic) IBOutlet UILabel *planDayInfoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *planIconImg;
@property (weak, nonatomic) IBOutlet UIImageView *planTitleImg;
@property (weak, nonatomic) IBOutlet UILabel *planTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *planDesImg;

@property (weak, nonatomic) IBOutlet UILabel *planDesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *planTipsImg;

@property (weak, nonatomic) IBOutlet UILabel *planLineLabel;

@end
