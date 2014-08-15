//
//  TripNoteModel.m
//  LeoYou
//
//  Created by Chiong on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "TripNoteModel.h"

@implementation TripNoteModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //NSLog(@"undefinedkey in trpNote %@", key);
}

- (CGFloat)getDescriptionHeight
{
    if (self.description.length > 0) {
        NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        // 根据第一个参数的文本内容，使用280*float最大值的大小，使用系统14号字，返回一个真实的frame size : (280*xxx)!!
        CGRect frame = [self.description boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return frame.size.height;
    } else {
        return 0;
    }
}

- (CGFloat)getPhotoHeight
{
    if (self.photo.count > 0) {
        NSDictionary *photo = self.photo;
        CGFloat imageHeight = [[photo objectForKey:@"image_height"] floatValue];
        CGFloat imageWidth = [[photo objectForKey:@"image_width"] floatValue];
        return 300*imageHeight/imageWidth;
    } else {
        return 0;
    }
}

@end
