//
//  MapAttractionViewController.h
//  LeoYou
//
//  Created by Chiong on 14-7-13.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//显示attraction的地图
#import "RootViewController.h"
#import <MapKit/MapKit.h>

@interface MapAttractionViewController : RootViewController

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *nodesArray;

@end
