//
//  HeaderView.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-9.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderView : UIView

- (id)initWithTitleArray:(NSArray *)array target:(id)target frame:(CGRect)frame labelWidth:(CGFloat)width action:(SEL)action;

@end
