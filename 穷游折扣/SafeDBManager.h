//
//  SafeDBManager.h
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "outlineModel.h"

@interface SafeDBManager : NSObject

+(SafeDBManager *)shareManager;
- (void)insertDataWithModel:(outlineModel *)model withLoginName:(NSString *)loginName;

- (NSArray *)fetchAllUsersWithLoginName:(NSString *)loginName;

- (void)deleteDataWithOutlineID:(NSString *)outlineID withLoginName:(NSString *)loginName;

- (BOOL)isCollectedWithOutlineID:(NSString *)outlineID withLoginName:(NSString *)loginName;


@end
