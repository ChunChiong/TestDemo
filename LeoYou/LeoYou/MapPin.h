//
//  MapPin.h
//  LeoYou
//
//  Created by Chiong on 14-7-13.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPin : NSObject<MKAnnotation>

@property (nonatomic, assign) NSInteger tag;

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)sub lc2d:(CLLocationCoordinate2D)lc2d;

@end
