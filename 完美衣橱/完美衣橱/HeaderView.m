//
//  HeaderView.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-9.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitleArray:(NSArray *)array target:(id)target frame:(CGRect)frame labelWidth:(CGFloat)width action:(SEL)action
{
    self = [super initWithFrame:frame];
    if(self){
    for (int i= 0; i<array.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        CGFloat Xspace = (320-array.count*width)/(array.count+1);
        button.frame = CGRectMake(Xspace+i*(width+Xspace), 5, width, 20);
        [button setBackgroundImage:[UIImage imageNamed:@"button_Seg_normal"] forState:UIControlStateNormal];
        button.tag = 100+i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:9]];
        [self addSubview:button];
        }
      
    }
    return self;
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
