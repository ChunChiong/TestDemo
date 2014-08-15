//
//  TripNoteCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-11.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface TripNoteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *noteNodeImg;
@property (weak, nonatomic) IBOutlet UILabel *noteNodeName;
@property (weak, nonatomic) IBOutlet UILabel *noteNodeInfoLabel;
@property (weak, nonatomic) IBOutlet StarView *noteNodeStarView;

@property (weak, nonatomic) IBOutlet UILabel *noteDesLabel;
@property (weak, nonatomic) IBOutlet UIButton *noteImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *noteNameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *noteLocImg;
@property (weak, nonatomic) IBOutlet UILabel *noteBottomLabel;



@end
