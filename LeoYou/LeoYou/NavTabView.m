//
//  NavTabView.m
//  LeoYou
//
//  Created by Chiong on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "NavTabView.h"

@implementation NavTabView {
    UIButton *_selectedBtn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame buttonArray:(NSArray*)array
{
    if (self = [super initWithFrame:frame]) {
        CGFloat btnWidth = 60;
        NSInteger btnNum = [array count];
        CGFloat space = (320 - btnWidth*btnNum)/(btnNum*2);
        for (int i= 0; i<[array count]; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((btnWidth+space)*i+space*(i+1), 0, btnWidth, 30);
            [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            if (i == 0) {
                button.selected = YES;
                _selectedBtn = button;
            }
            button.tag = i;
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, 320, 1)];
        label.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:label];
    }
    return self;
}

- (void)buttonClick:(UIButton *)button
{
    _selectedBtn.selected = NO;
    _selectedBtn = button;
    _selectedBtn.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(tabBtnClicked:)]) {
        [self.delegate tabBtnClicked:button.tag];
    }
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
