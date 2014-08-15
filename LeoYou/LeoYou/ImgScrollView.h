//
//  ImgScrollView.h
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgScrollView : UIView

@property (nonatomic, strong) NSArray *photoArray;
- (void)createScrollView;
@end
