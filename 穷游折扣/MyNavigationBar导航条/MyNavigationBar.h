//
//  MyNavigationBar.h
//  MyNavigationController
//
//  Created by Visitor on 14-4-27.
//  Copyright (c) 2014年 Visitor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationBar : UIView

- (void)createMyNavigationBarWithBackgroundImageName:(NSString *)backgroundImageName andTitle:(NSString *)title andTitleImageName:(NSString *)titleImageName andLeftBBIImageName:(NSArray *)leftBBIImageName andRigtBBIImageName:(NSArray *)rightBBIImageName andClass:(id)classObject andSEL:(SEL)sel;

- (void)createBBIWithImageName:(NSArray *)imageNames andIsLeft:(BOOL)isLeft andClass:(id)classObject andSEL:(SEL)sel;





@end





