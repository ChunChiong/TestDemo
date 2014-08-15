//
//  TripNoteModel.h
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripNodeModel.h"

@interface TripNoteModel : NSObject
//node
@property (nonatomic, strong) TripNodeModel *tripNodeModel;

//notes的基本信息
@property (nonatomic, assign) NSInteger col;
@property (nonatomic, copy) NSString *description;//简介
@property (nonatomic, assign) NSInteger noteID;


/*
 photo =         {
 "exif_date_time_original" = 1380649199;
 "exif_lat" = "<null>";
 "exif_lng" = "<null>";
 id = 5420948;
 "image_file_size" = 287803;
 "image_height" = 1064;
 "image_width" = 1600;
 url = "http://cyj.qiniudn.com/139778/1404569883357p18s3e74md9va1ee51s9c1c1v11pk2.jpg";
 };
 */
@property (nonatomic, strong) NSDictionary *photo;//照片



//@property (nonatomic, assign) NSInteger comments_count;
//@property (nonatomic, assign) NSInteger likes_count;

- (CGFloat)getDescriptionHeight;
- (CGFloat)getPhotoHeight;

@end
