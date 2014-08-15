//
//  AritcleModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-12.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AritcleModel : NSObject

@property (nonatomic, assign) NSInteger AttractionID;
@property (nonatomic, copy) NSString *AttractionName;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) NSDictionary *description_user_ids;
@property (nonatomic, assign) CGFloat image_height;
@property (nonatomic, assign) CGFloat image_width;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *title;
//得到介绍的高度
- (CGFloat)getDesHeight;
//得到图片的高度
- (CGFloat)getImgHeight;

@end
