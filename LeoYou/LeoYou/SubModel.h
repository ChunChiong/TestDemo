//
//  SubModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-9.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubModel : NSObject

@property (nonatomic, assign) NSInteger destination_id;
@property (nonatomic, assign) NSInteger subID;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger updated_at;

@end
