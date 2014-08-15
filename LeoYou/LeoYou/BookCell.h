//
//  BookCell.h
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookCnLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookEnLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookSubBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookTipsBtn;

@property (weak, nonatomic) IBOutlet UIButton *bookTripBtn;
@property (weak, nonatomic) IBOutlet UIButton *bookDesBtn;
@property (weak, nonatomic) IBOutlet UILabel *bookSubNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookTripNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookDesNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookImgBtn;


@end
