//
//  LocationCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"

@interface LocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *locImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *locNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *locNameLabel;
@property (weak, nonatomic) IBOutlet StarView *locStarView;
@property (weak, nonatomic) IBOutlet UILabel *locDescLabel;

@end
