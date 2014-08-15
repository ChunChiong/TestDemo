//
//  ArticleCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-12.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *articleImgBtn;
@property (weak, nonatomic) IBOutlet UILabel *articleDesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleLocImg;
@property (weak, nonatomic) IBOutlet UIButton *articleLocName;
@property (weak, nonatomic) IBOutlet UILabel *articleBottomLabel;

@end
