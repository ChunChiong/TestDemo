//
//  TravelCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravelCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *travelmageView;
@property (weak, nonatomic) IBOutlet UILabel *travelTitlelabel;
@property (weak, nonatomic) IBOutlet UILabel *travelDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelDetailLabel;

@end
