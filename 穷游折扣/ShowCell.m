//
//  ShowCell.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import "ShowCell.h"

@implementation ShowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)LButtonClick:(id)sender {
        NSLog(@"ShowCell:%@",self.lModel.outlineID);
    if ([_delegate respondsToSelector:@selector(pushID:)]) {
        [_delegate performSelector:@selector(pushID:) withObject:self.lModel];

    }
    
}

- (IBAction)RButtonClick:(UIButton *)sender {
            NSLog(@"ShowCell:%@",self.rModel.outlineID);
    if ([_delegate respondsToSelector:@selector(pushID:)]) {
        [_delegate performSelector:@selector(pushID:) withObject:self.rModel];
    }
}

@end
