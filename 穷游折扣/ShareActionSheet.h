//
//  ShareActionSheet.h
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareActionSheet : UIActionSheet

@property(nonatomic,strong)UIView *view;
@property(nonatomic,strong)UIToolbar *toolBar;

- (id)initWithHeight:(float)height WithSheetTitle:(NSString *)title;
@end
