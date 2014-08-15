//
//  StarView.m
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "StarView.h"

@implementation StarView {
    UIImageView *_frontStar;
    UIImageView *_backStar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createStar];
    }
    return self;
}

- (void)createStar
{
    _backStar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 56, 9)];
    [_backStar setImage:[UIImage imageNamed:@"StarNormal"]];
    [self addSubview:_backStar];

    _frontStar = [[UIImageView alloc] initWithFrame:_backStar.frame];
    [_frontStar setImage:[UIImage imageNamed:@"StarHighlight"]];
    _frontStar.contentMode = UIViewContentModeLeft;
    _frontStar.clipsToBounds = YES;
    [self addSubview:_frontStar];
}

- (void)setWidthWithScore:(CGFloat)score
{
    CGRect frame = _backStar.frame;
    frame.size.width = score*frame.size.width/5;
    _frontStar.frame = frame;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
