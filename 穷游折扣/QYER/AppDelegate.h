//
//  AppDelegate.h
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>


#define APPLEGATE ((AppDelegate*)([UIApplication sharedApplication].delegate))
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)PPRevealSideViewController *revealSideViewController;
-(void)showviewcontroller;
@end
