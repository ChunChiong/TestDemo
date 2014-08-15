//
//  DBManager.h
//  LeoYou
//
//  Created by 赵 辉 on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TripModel.h"
@interface DBManager : NSObject
+ (DBManager *)sharedManger;

//crud for trip
- (void)insertTrip:(TripModel *)trip;
- (void)deleteTrip:(TripModel *)trip;
- (NSArray *)showAllTrip;
- (BOOL)isTripExist:(TripModel *)trip;
- (NSInteger)getNumOfTrip;
- (void)clearAllTrip;

@end
