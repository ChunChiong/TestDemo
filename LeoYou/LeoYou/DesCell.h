//
//  DesCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *DesLeftButton;
@property (weak, nonatomic) IBOutlet UILabel *desLeftNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLeftCnLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLeftEnLabel;
@property (weak, nonatomic) IBOutlet UIButton *desRightButton;
@property (weak, nonatomic) IBOutlet UILabel *desRightNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *desRightCnLabel;
@property (weak, nonatomic) IBOutlet UILabel *desRightEnLabel;

@end
