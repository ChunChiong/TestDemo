//
//  ImgScrollView.m
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "ImgScrollView.h"
#import "UIImageView+WebCache.h"

@implementation ImgScrollView {
    UIScrollView *_scrollView;
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
    if (self = [super initWithCoder:aDecoder]) {
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    [self addSubview:_scrollView];
}

- (void)createScrollView
{
    CGFloat width = 0;
    for (int i=0; i<[self.photoArray count]; i++) {
        NSDictionary *note = [self.photoArray objectAtIndex:i];
        CGFloat photoHeight = [[note objectForKey:@"height"] floatValue];
        CGFloat photoWidth = [[note objectForKey:@"width"] floatValue];
        CGFloat subWidth = (100 * photoWidth) / photoHeight;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(width+3*i, 0, subWidth, 100)];
        width += subWidth;
        [imageView setImageWithURL:[NSURL URLWithString:[note objectForKey:@"photo_url"]]];
        [_scrollView addSubview:imageView];
    }
    width += ([self.photoArray count]-1)*3;
    _scrollView.contentSize = CGSizeMake(width, 100);
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
