//
//  AttentionDetailCell.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-11.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
