//
//  PlanNodeModel.m
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "PlanNodeModel.h"

@implementation PlanNodeModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

- (CGFloat)getTipsHeight
{
    if (self.tips.length > 0) {
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGRect frame = [self.tips boundingRectWithSize:CGSizeMake(247, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
        return frame.size.height;
    } else {
        return 0;
    }
}

@end
