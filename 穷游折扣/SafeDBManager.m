//
//  SafeDBManager.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "SafeDBManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"


@implementation SafeDBManager{
    FMDatabaseQueue *_databaseQueue;
}

+ (SafeDBManager *)shareManager{
    static SafeDBManager *manager = nil;
    @synchronized(self){
        if (manager==nil) {
            manager = [[SafeDBManager alloc]init];
        }
    }
    return manager;
}

- (id)init{
    if (self=[super init]) {
        NSString *path = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/outline.db"];
        _databaseQueue = [[FMDatabaseQueue alloc]initWithPath:path];
       [ _databaseQueue inDatabase:^(FMDatabase *db) {
            NSString *createSQL = @"create table if not exists itemInfo(id integer primary key autoincrement,outlineID varchar(256),title varchar(256),price varchar(256),firstpay_end_time varchar(256),pic varchar(1024),loginName varchar(256))";
            BOOL isSucceed = [db executeUpdate:createSQL];
            if (!isSucceed) {
                NSLog(@"error:%@",db.lastErrorMessage);
            }
       }];
    }
    return self;
}

- (void)insertDataWithModel:(outlineModel *)model withLoginName:(NSString *)loginName{
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *insertSQL = @"insert into itemInfo(outlineID,title,price,firstpay_end_time,pic,loginName)values(?,?,?,?,?,?)";
        BOOL isSucceed = [db executeUpdate:insertSQL,model.outlineID,model.title,model.price,model.firstpay_end_time,model.pic,loginName];
        if (!isSucceed) {
            NSLog(@"insertError:%@",db.lastErrorMessage);
        }
        
    }];
}

- (NSArray *)fetchAllUsersWithLoginName:(NSString *)loginName{
    NSMutableArray *array = [NSMutableArray array];
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *selectSQL = @"select * from itemInfo where loginName=?";
        FMResultSet *set = [db executeQuery:selectSQL,loginName];
        while ([set next]) {
            outlineModel *model = [[outlineModel alloc]init];
            model.outlineID = [set stringForColumn:@"outlineID"];
            model.title = [set stringForColumn:@"title"];
            model.price = [set stringForColumn:@"price"];
            model.firstpay_end_time = [set stringForColumn:@"firstpay_end_time"];
            model.pic = [set stringForColumn:@"pic"];
            [array addObject:model];
        }
        
    }];
    return array;
}

- (void)deleteDataWithOutlineID:(NSString *)outlineID withLoginName:(NSString *)loginName{
    [_databaseQueue inDatabase:^(FMDatabase *db) {
       NSString *deleteSQL = @"delete from itemInfo where outlineID=? and loginName=?";
        BOOL isSucceed = [db executeUpdate:deleteSQL,outlineID,loginName];
        if (!isSucceed) {
            NSLog(@"%@",db.lastErrorMessage);
        }
    }];
}

- (BOOL)isCollectedWithOutlineID:(NSString *)outlineID withLoginName:(NSString *)loginName{
    __block BOOL isCollected;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *selectSQL = @"select * from itemInfo where loginName=? and outlineID=?";
        FMResultSet *set = [db executeQuery:selectSQL,loginName,outlineID];
        isCollected = [set next];
    }];
    return isCollected;
}

















@end
