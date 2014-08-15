//
//  MapPin.m
//  LeoYou
//
//  Created by Chiong on 14-7-13.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "MapPin.h"

@implementation MapPin{
    NSString *_title;
    NSString *_subTitle;
    CLLocationCoordinate2D _lc2d;
}

- (id)initWithTitle:(NSString *)title subTitle:(NSString *)sub lc2d:(CLLocationCoordinate2D)lc2d
{
    if (self = [super init]) {
        _title = [title copy];
        _subTitle = [sub copy];
        _lc2d = lc2d;
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return _lc2d;
}

- (NSString *)title
{
    return _title;
}

- (NSString *)subtitle
{
    return _subTitle;
}


@end
