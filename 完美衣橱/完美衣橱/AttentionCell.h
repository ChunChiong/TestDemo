//
//  AttentionCell.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-8.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *flow_timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flow_imageView;
@property (weak, nonatomic) IBOutlet UILabel *LikeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *ForwardLabel;
@property (weak, nonatomic) IBOutlet UIButton *LikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *CommmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *ForwardBtn;
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;

@end
