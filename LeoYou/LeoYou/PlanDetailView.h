//
//  PlanDetailView.h
//  LeoYou
//
//  Created by 赵 辉 on 14-7-11.
//  Copyright (c) 2014年 Leo. All rights reserved.
//
//在游记页滑出的视图
#import <UIKit/UIKit.h>

@protocol PlanDetailDelegate <NSObject>

- (void)planDetailSectionDidSelectedAtIndexPath:(NSIndexPath *)indexPath;
//当mapButton被点击的方法
- (void)planMapButtonClicked;

@end

@interface PlanDetailView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<PlanDetailDelegate> delegate;

- (id)initWithNodeArray:(NSArray *)nodeArray Frame:(CGRect)frame;

//划出tableView
- (void)showTableView;
//收起来tableView
- (void)hideTableView;
//刷新tableView
- (void)reloadDataWithArray:(NSArray *)array;

@end
