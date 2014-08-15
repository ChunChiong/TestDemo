//
//  Tool.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-8.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "Tool.h"

@implementation Tool

- (UIImageView *)imageViewWithFrame:(CGRect)frame1 label:(UILabel *)titleLabel LabelFrame:(CGRect)frame2 labelText:(NSString *)text
{
    titleLabel.frame = frame2;
    titleLabel.text = text;
    titleLabel.backgroundColor = [UIColor lightGrayColor];
    titleLabel.alpha = 0.5;
    UIImageView *view = [[UIImageView alloc] initWithFrame:frame1];
    [view addSubview:titleLabel];
    return view;
    
}
@end
