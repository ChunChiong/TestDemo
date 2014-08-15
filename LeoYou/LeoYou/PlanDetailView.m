//
//  PlanDetailView.m
//  LeoYou
//
//  Created by 赵 辉 on 14-7-11.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "PlanDetailView.h"
#import "PlanCell.h"
#import "TripNodeModel.h"
#import "MapAttractionViewController.h"

@implementation PlanDetailView {
    NSArray *_dataArray;
    UITableView *_tableView;
    UIView *_headView;
    UILabel *_headViewLabel;
    UIButton *_headViewBtn;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithNodeArray:(NSArray *)nodeArray Frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createFixedHeader];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, 180, [DeviceManager screenHeight] - 64- 80) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.alpha = 0.8;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
        _dataArray = nodeArray;
    }
    return self;
}

- (void)showTableView
{
    CGRect viewFrame = self.frame;
    viewFrame.size.width = 380.f;
    self.frame = viewFrame;
    
    CGRect tableFrame = _tableView.frame;
    tableFrame.size.width = 180.f;
    _tableView.frame = tableFrame;
    
    CGRect headFrame = _headView.frame;
    headFrame.size.width = 180.f;
    _headView.frame = headFrame;
    
    CGRect headLabelFrame = _headViewLabel.frame;
    headLabelFrame.size.width = 180.f;
    _headViewLabel.frame = headLabelFrame;
    
    CGRect headBtnFrame = _headViewBtn.frame;
    headBtnFrame.size.width = 180.f;
    _headViewBtn.frame = headBtnFrame;
}

- (void)hideTableView
{
    CGRect viewFrame = self.frame;
    viewFrame.size.width = 0.f;
    self.frame = viewFrame;
    
    CGRect tableFrame = _tableView.frame;
    tableFrame.size.width = 0.f;
    _tableView.frame = tableFrame;
    
    CGRect headFrame = _headView.frame;
    headFrame.size.width = 0.f;
    _headView.frame = headFrame;
    
    CGRect headLabelFrame = _headViewLabel.frame;
    headLabelFrame.size.width = 0.f;
    _headViewLabel.frame = headLabelFrame;
    
    CGRect headBtnFrame = _headViewBtn.frame;
    headBtnFrame.size.width = 0.f;
    _headViewBtn.frame = headBtnFrame;

}

- (void)createFixedHeader
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 80)];
    _headView.backgroundColor = [UIColor blackColor];
    _headView.alpha = 0.8;
    
    _headViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 20)];
    _headViewLabel.text = @"行程概览";
    _headViewLabel.textColor = [UIColor whiteColor];
    _headViewLabel.font = [UIFont boldSystemFontOfSize:17];
    [_headView addSubview:_headViewLabel];
    
    _headViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headViewBtn setFrame:CGRectMake(10, 40, 80, 20)];
    _headViewBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    _headViewBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_headViewBtn setTitle:@"查看行程地图" forState:UIControlStateNormal];
    [_headViewBtn addTarget:self action:@selector(headViewBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_headView addSubview:_headViewBtn];
    [self addSubview:_headView];
}

//当mapbtn被点击
- (void)headViewBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(planMapButtonClicked)]) {
        [self.delegate planMapButtonClicked];
    }
}



#pragma mark tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"plan";
    PlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PlanCell" owner:self options:nil] lastObject];
    }
    TripNodeModel *model = [[_dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.planNameLabel.text = model.entry_name;
    cell.alpha = 1;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 42.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, 42)];
    view.backgroundColor = [UIColor clearColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 10, 42)];
    [imgView setImage:[UIImage imageNamed:@"OutlineDay"]];
    [view addSubview:imgView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 30)];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"DAY%d", section+1];
    [label setFont:[UIFont boldSystemFontOfSize:14]];
    label.alpha = 1;
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(planDetailSectionDidSelectedAtIndexPath:)]) {
        [self.delegate planDetailSectionDidSelectedAtIndexPath:indexPath];
    }
}

- (void)reloadDataWithArray:(NSArray *)array
{
    NSLog(@"%@", _dataArray);
    _dataArray = array;
    [_tableView reloadData];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
