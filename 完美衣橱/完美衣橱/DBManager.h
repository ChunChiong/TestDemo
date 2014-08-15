//
//  DBManager.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-21.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YichuModel.h"

@interface DBManager : NSObject

+ (DBManager *)shareManager;
//利用YichuModel 向数据库插入数据
- (void)insertDataWithModel:(YichuModel *)model;
//删除
- (void)deleteDataWithUserId:(NSInteger)userId;
//修改数据
- (void)upDateWithModel:(YichuModel *)model userId:(NSInteger)userId;

//获取全部数据
-  (NSArray *)fetchAllUsers;

@end
