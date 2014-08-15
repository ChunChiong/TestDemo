//
//  AritcleModel.m
//  LeoYou
//
//  Created by Chiong on 14-7-12.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "AritcleModel.h"

@implementation AritcleModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

//得到介绍的高度
- (CGFloat)getDesHeight
{
    if (self.description.length > 0) {
        NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGRect frame = [self.description boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return frame.size.height;
    } else {
        return 0;
    }
    
}


//得到图片的高度
- (CGFloat)getImgHeight
{
    return 320*self.image_height/self.image_width;
}


@end
