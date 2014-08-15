//
//  TripCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TripBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *TripNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TripInfoLabel;
@property (weak, nonatomic) IBOutlet UIButton *TripUserBtn;


@end
