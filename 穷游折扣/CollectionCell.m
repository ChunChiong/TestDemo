//
//  CollectionCell.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

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

@end
