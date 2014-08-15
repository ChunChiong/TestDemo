//
//  DBManager.m
//  LeoYou
//
//  Created by 赵 辉 on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@implementation DBManager
{
    FMDatabase *_dataBase;
}

+ (DBManager *)sharedManger
{
    static DBManager *manager = nil;
    if (manager == nil) {
        manager = [[DBManager alloc] init];
    }
    return manager;
}

//重写init方法,来创建表
- (id)init
{
    if (self = [super init]) {
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/leoyouji.db"];
        _dataBase = [[FMDatabase alloc] initWithPath:path];
        if ([_dataBase open]) {
            NSString *createTrip = @"create table if not exists trip(id integer primary key, front_cover_photo_url varchar(2048), user_img varchar(2048), name varchar(256), start_date varchar(256), days integer, photos_count integer)";
            if (![_dataBase executeUpdate:createTrip]) {
                NSLog(@"create error %@", _dataBase.lastErrorMessage);
            }
        }
    }
    return self;
}

- (void)insertTrip:(TripModel *)trip
{
    if ([self isTripExist:trip]) {
        return;
    }
    NSString *insertSql = @"insert into trip(id, front_cover_photo_url, user_img, name, start_date, days, photos_count) values (?, ?, ?, ?, ?, ?, ?)";
    NSDictionary *userInfo = trip.user;
    BOOL isSuccessed = [_dataBase executeUpdate:insertSql, [NSString stringWithFormat:@"%d", trip.tripID], trip.front_cover_photo_url, [userInfo objectForKey:@"image"], trip.name, trip.start_date, [NSString stringWithFormat:@"%d", trip.days], [NSString stringWithFormat:@"%d", trip.photos_count]];
    if (!isSuccessed) {
        NSLog(@"create error %@", _dataBase.lastErrorMessage);
    }
}

- (void)deleteTrip:(TripModel *)trip
{
    NSString *tripID = [NSString stringWithFormat:@"%d", trip.tripID];
    NSString *delSql = @"delete from trip where id = ?";
    if (![_dataBase executeUpdate:delSql, tripID]) {
        NSLog(@"delete error:%@", _dataBase.lastErrorMessage);
    }
    
}

- (NSArray *)showAllTrip
{
    NSString *sql = @"select * from trip";
    FMResultSet *set = [_dataBase executeQuery:sql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        TripModel *model = [[TripModel alloc] init];
        model.tripID = [[set stringForColumn:@"id"] integerValue];
        model.days= [[set stringForColumn:@"days"] integerValue];
        model.photos_count = [[set stringForColumn:@"photos_count"] integerValue];
        model.name = [set stringForColumn:@"name"];
        model.front_cover_photo_url = [set stringForColumn:@"front_cover_photo_url"];
        model.start_date = [set stringForColumn:@"start_date"];
        NSMutableDictionary *user = [NSMutableDictionary dictionary];
        [user setObject:[set stringForColumn:@"user_img"] forKey:@"image"];
        model.user = user;
        [array addObject:model];
    }
    return array;
}

- (BOOL)isTripExist:(TripModel *)trip
{
    NSString *sql = @"select * from trip where id = ?";
    FMResultSet *set = [_dataBase executeQuery:sql, [NSString stringWithFormat:@"%d", trip.tripID]];
    return [set next];
    
}

- (void)clearAllTrip
{
    NSString *sql = @"delete from trip";
    if (![_dataBase executeUpdate:sql]) {
        NSLog(@"clear error:%@", [_dataBase lastErrorMessage]);
    }
}

- (NSInteger)getNumOfTrip;
{
    NSString *sql = @"select * from trip";
    FMResultSet *set = [_dataBase executeQuery:sql];
    int num = 0;
    while ([set next]) {
        num++;
    }
    return num;
}




@end