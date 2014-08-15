//
//  ShareActionSheet.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "ShareActionSheet.h"

@implementation ShareActionSheet

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithHeight:(float)height WithSheetTitle:(NSString *)title{
    if (self=[super init]) {
        int theight = height-40;
        int btnnum = theight/50;
        for (int i = 0; i<btnnum; i++) {
            [self addButtonWithTitle:@"拉拉"];
        }
    }
    
    
    _view = [[UIView alloc]initWithFrame:CGRectMake(0, 84, 320, height-44)];
    _view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 30, 200, 20);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_view addSubview:button];
    
    [self addSubview:_view];
    return self;
}

- (void)cancelButtonClick{
    [self dismissWithClickedButtonIndex:0 animated:YES];
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
