//
//  ShowCell.h
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "outlineModel.h"
#import "DetailViewController.h"

@protocol ShowCellDelegate <NSObject>

- (void)pushID:(NSString *)outlineID;

@end

@interface ShowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *LSelfUseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *RSelfUseImageView;
@property (weak, nonatomic) IBOutlet UILabel *RpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *LpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *RtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *RtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *LtimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *LimageView;
@property (weak, nonatomic) IBOutlet UIImageView *RimageView;
@property (weak, nonatomic) IBOutlet UILabel *LtitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *LButton;
@property (weak, nonatomic) IBOutlet UIButton *RButton;
@property (nonatomic,assign) id<ShowCellDelegate>delegate;
@property(nonatomic,strong)outlineModel *lModel;
@property(nonatomic,strong)outlineModel *rModel;
@property (weak, nonatomic) IBOutlet UILabel *Llastminute_desLabel;
@property (weak, nonatomic) IBOutlet UILabel *Rlastminute_desLabel;

- (IBAction)LButtonClick:(UIButton*)sender;
- (IBAction)RButtonClick:(UIButton *)sender;


@end
