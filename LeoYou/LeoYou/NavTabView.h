//
//  NavTabView.h
//  LeoYou
//
//  Created by Chiong on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//tab导航视图
#import <UIKit/UIKit.h>

@protocol NavTabViewDelegate <NSObject>

- (void)tabBtnClicked:(NSInteger)tag;

@end

@interface NavTabView : UIView

@property (nonatomic, weak) id<NavTabViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame buttonArray:(NSArray*)array;

@end
