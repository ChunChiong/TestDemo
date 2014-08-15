//
//  StarView.h
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//评星
#import <UIKit/UIKit.h>

@interface StarView : UIView

//根据分数调整星星大小
- (void)setWidthWithScore:(CGFloat)score;

@end
