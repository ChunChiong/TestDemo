//
//  DBManager.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-21.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@implementation DBManager{
    FMDatabase *_dataBase;
}

static DBManager *manager = nil;//指初始化一次

+ (DBManager *)shareManager
{
    if (manager == nil) {
        manager = [[DBManager alloc] init];
    }
    return manager;
}

- (id)init
{
    self = [super init];
    if(self){
        
        NSString *dbPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/Yichu.db"];
        _dataBase = [[FMDatabase alloc] initWithPath:dbPath];
        [_dataBase open];
        if ([_dataBase open]) {
            NSString *createSql = @"create table if not exists YichuInfo(id integer primary key autoincrement, name varchar(256),price integer,image blod)";
            BOOL isSuccessed = [_dataBase executeUpdate:createSql];
            if (!isSuccessed) {
                NSLog(@"createError:%@",_dataBase.lastErrorMessage);
            }
        }
    }
    return self;
}

//向数据库插入数据
- (void)insertDataWithModel:(YichuModel *)model
{
    UIImage *image = model.Image;
    
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *insertSql = @"insert into YichuInfo(name,price,image) values(?,?,?)";
    
    BOOL isSuccessed = [_dataBase executeUpdate:insertSql,model.sortName,model.price,data];
    if (!isSuccessed) {
        NSLog(@"insert error : %@",_dataBase.lastErrorMessage);
    }
    
}

//删除
- (void)deleteDataWithUserId:(NSInteger)userId
{
    NSString *deleteSql = @"delete from YichuInfo where id = ?";
    if (![_dataBase executeUpdate:deleteSql,[NSNumber numberWithInteger:userId]]) {
        NSLog(@"delete error : %@",_dataBase.lastErrorMessage);
    }
}

//修改数据
- (void)upDateWithModel:(YichuModel *)model userId:(NSInteger)userId
{
    NSData *data = UIImagePNGRepresentation(model.Image);
    NSString *updataSql = @"update YichuInfo set name =?,age =?,image =? where id=?";
    BOOL isSuccess = [_dataBase executeUpdate:updataSql,model.sortName,model.price,data,[NSNumber numberWithInteger:userId]];
    if (!isSuccess) {
        NSLog(@"update error:%@",_dataBase.lastErrorMessage);
    }
}

- (NSArray *)fetchAllUsers
{
    NSString *selectAql = @"select * from YichuInfo";
    FMResultSet *set = [_dataBase executeQuery:selectAql];
    NSMutableArray *array = [NSMutableArray array];
    while ([set next]) {
        YichuModel *model = [[YichuModel alloc] init];
        model.sortName = [set stringForColumn:@"name"];
        model.price = [set stringForColumn:@"price"];
        NSData *data = [set dataForColumn:@"image"];
        model.Image = [UIImage imageWithData:data];
        [array addObject:model];
        
    }
    return  array;
}









@end
