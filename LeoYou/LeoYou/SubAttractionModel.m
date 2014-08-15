//
//  SubAttractionModel.m
//  LeoYou
//
//  Created by Chiong on 14-7-15.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//attraction详情的model
#import "SubAttractionModel.h"

@implementation SubAttractionModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

- (CGFloat)getDescriptionHeight
{
    NSLog(@"%@", self.description);
    if (self.description.length > 0) {
        NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
        CGRect frame = [self.description boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        return frame.size.height;
    } else {
        return 0;
    }
}

- (NSString *)getDateStr
{
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setDateFormat:@"y-M-d"];
    NSString *dateStr = [formate stringFromDate:[NSDate dateWithTimeIntervalSince1970:self.updated_at]];
    return dateStr;
}

@end
