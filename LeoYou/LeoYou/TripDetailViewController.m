//
//  TripDetailViewController.m
//  LeoYou
//
//  Created by 赵 辉 on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "TripDetailViewController.h"
#import "TripNoteModel.h"
#import "TripModel.h"
#import "TripNodeModel.h"
#import "TripNoteCell.h"
#import "StarView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "PlanDetailView.h"
#import "MapAttractionViewController.h"
#import "TripCell.h"
#import "SVProgressHUD.h"
#import "HttpRequestManager.h"
#import "UMSocial.h"
#import "DBManager.h"
#import "LeoDateManager.h"

//todo bug:使用缓存后，button就不显示了....

@interface TripDetailViewController ()<PlanDetailDelegate, HttpRequestManagerDelegate> {
    TripModel *_tripModel;
    UIButton *_planBtn;//用于推出planDetailView
    PlanDetailView *_planDetailView;
    NSMutableArray *_planNodesArray;//用于planDetailView的datasource
    NSMutableArray *_nodePositionArray;//用于记录node的位置
    HttpRequestManager *_httpRequest;
}

@end

@implementation TripDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tripModel = [[TripModel alloc] init];
    _planNodesArray = [[NSMutableArray alloc] init];
    _nodePositionArray = [[NSMutableArray alloc] init];
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
    
    [self.dataArray removeAllObjects];
    [_planNodesArray removeAllObjects];
    [_nodePositionArray removeAllObjects];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.allowsSelection = NO;
    [self createTableViewHeaderView];
    
    _planBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _planBtn.frame = CGRectMake(20, [DeviceManager screenHeight] - 64 - 40 - 20, 40, 40);
    _planBtn.backgroundColor = [UIColor blackColor];
    _planBtn.alpha = 0.8;
    //_planBtn.hidden = YES;
    
    [_planBtn setImage:[UIImage imageNamed:@"IconPlan"] forState:UIControlStateNormal];
    [_planBtn addTarget:self action:@selector(showPlanDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_planBtn];
    
    _planDetailView = [[PlanDetailView alloc] initWithNodeArray:_planNodesArray Frame:CGRectMake(0, 0, 0, [DeviceManager screenHeight] -44)];
    [self.view addSubview:_planDetailView];
    [_planDetailView hideTableView];
    _planDetailView.delegate = self;
    
    [self customBackBtn];
    [self shareAndSaveBtn];
    [self setCustomTitle:self.model.name];
    [self hideCusTabBar];
}

#pragma mark share和save的方法
//重写share的方法
- (void)shareWithMessage:(NSString *)message
{
    message = [NSString stringWithFormat:@"#蝉游记#%@", self.model.name];
    [self shareMessageByUM:message];
}

//重写save
- (void)save
{
    [[DBManager sharedManger] insertTrip:self.model];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OK" message:@"收藏成功" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark 导航视图的控制
- (void)showPlanDetail
{
    [UIView animateWithDuration:0.5 animations:^{
        [_planDetailView showTableView];
        //_planBtn.hidden = YES;
    }];
    
}

- (void)hidePlanDetail
{
    if (_planDetailView.frame.size.width > 0) {
        [_planDetailView hideTableView];
        //_planBtn.hidden = NO;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hidePlanDetail];
}

- (void)createTableViewHeaderView
{
    TripCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TripCell" owner:self options:nil] lastObject];
    [cell.TripBgImageView setImageWithURL:[NSURL URLWithString:_model.front_cover_photo_url]];
    [cell.TripUserBtn setImageWithURL:[NSURL URLWithString:[_model.user objectForKey:@"image"]]];
    cell.TripNameLabel.text = _model.name;
    NSString *info = [NSString stringWithFormat:@"%@|%d天%d图", _model.start_date, _model.days, _model.photos_count];
    cell.TripInfoLabel.text = info;
    cell.TripBgImageView.frame = CGRectMake(0, 0, 320, 190);
    cell.TripNameLabel.frame = CGRectMake(60, 130, 220, 30);
    cell.TripNameLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.TripNameLabel.numberOfLines = 0;
    cell.TripInfoLabel.frame = CGRectMake(60, 150, 220, 20);
    cell.TripInfoLabel.font = [UIFont boldSystemFontOfSize:10];
    
    self.tableView.tableHeaderView = cell;
    
    
}

- (void) loadData
{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
    NSString *urlStr = [NSString stringWithFormat:kURLTripArticle, _model.tripID];
    [_httpRequest requestDataWithURLStr:urlStr];
}

#pragma http request manager delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error:%@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    //todo社交的信息
    //因为得到的数据比较复杂，翻译成下的结构，(方便构建tableView的版本)
    /*
     [
     day1:[
     note1,//其中第一个保留node的信息
     note2
     ],
     day2:[
     note3,
     note4
     ],
     
     ];
     */
    
    
    //获取到trip_days的信息，以确定小组
    if (![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    for (NSDictionary *tripDaysDict in [data objectForKey:@"trip_days"]) {
        NSMutableArray *tripDayNotesArray = [[NSMutableArray alloc] init];//用于保存当天的nodes
        NSMutableArray *planDayNodeArray = [[NSMutableArray alloc] init];//用于保存当天的nodes
        NSMutableArray *planDayNodePosArray = [[NSMutableArray alloc] init];//用于保存当天的node位置
        
        //获取到这天的node信息
        int i = 0;
        for (NSDictionary *nodesDict in [tripDaysDict objectForKey:@"nodes"]) {
            
            //保存node的基本信息
            TripNodeModel *tripNodeModel = [[TripNodeModel alloc] init];
            [tripNodeModel setValuesForKeysWithDictionary:nodesDict];
            //去掉空得内容
            if (tripNodeModel.entry_name.length != 0) {
                [planDayNodeArray addObject:tripNodeModel];
                [planDayNodePosArray addObject:[NSString stringWithFormat:@"%d", i]];
            }
            
            //获取nodes旗下的notes
            for (NSDictionary *notesDict in [nodesDict objectForKey:@"notes"]) {
                if ([[notesDict objectForKey:@"col"] isKindOfClass:[NSNull class]]) {
                    continue;
                }
                TripNoteModel *tripNoteModel = [[TripNoteModel alloc] init];
                tripNoteModel.tripNodeModel = tripNodeModel;
                [tripNoteModel setValuesForKeysWithDictionary:notesDict];
                [tripDayNotesArray addObject:tripNoteModel];
                i++;
            }
        }
        [self.dataArray addObject:tripDayNotesArray];
        
        [_planNodesArray addObject:planDayNodeArray];
        [_nodePositionArray addObject:planDayNodePosArray];
    }
    [self.tableView reloadData];
    //_planBtn.hidden = NO;
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellHeightWithSection:indexPath.section Row:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"tripnote";
    TripNoteCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TripNoteCell" owner:self options:nil] lastObject];
    }
    //设置cell的高度
    CGRect cellBounds = cell.bounds;
    cellBounds.size.height = [self getCellHeightWithSection:indexPath.section Row:indexPath.row];
    cell.bounds = cellBounds;
    
    //days
    NSArray *dayArray = [self.dataArray objectAtIndex:indexPath.section];
    //如果是第一个，我们配上node的信息
    TripNoteModel *noteModel =  [dayArray objectAtIndex:indexPath.row];
    TripNodeModel *nodeModel = noteModel.tripNodeModel;
    
    CGRect desFrame = CGRectMake(10, 2+40+8, 300, 88);//description默认的frame
    if (noteModel.col == 0 && nodeModel.entry_name.length > 0) {
        //名字
        cell.noteNodeName.text = nodeModel.entry_name;
        //entry_tilte换图片
        
        //info
        NSDictionary *memoInfo = nodeModel.memo;
        if (memoInfo.count > 0) {
            NSMutableString *nodeInfo = [NSMutableString stringWithString:@""];
            NSString *priceAmount = [memoInfo objectForKey:@"price_amount"];
            if (priceAmount.length > 0 && [priceAmount floatValue] > 0) {
                [nodeInfo appendFormat:@"门票%@", priceAmount];
            }
            
            NSString *time = [memoInfo objectForKey:@"time"];
            if (time.length > 0) {
                [nodeInfo appendFormat:@" 游览%@小时", time];
            }
            
            cell.noteNodeInfoLabel.text = nodeInfo;
            [cell.noteNodeStarView setWidthWithScore:nodeModel.score];
        }
        cell.noteNodeImg.hidden = NO;
        cell.noteNodeInfoLabel.hidden = NO;
        cell.noteNodeName.hidden = NO;
        cell.noteNodeStarView.hidden = NO;
        
    } else {
        //隐藏内容
        cell.noteNodeImg.hidden = YES;
        cell.noteNodeInfoLabel.hidden = YES;
        cell.noteNodeName.hidden = YES;
        cell.noteNodeStarView.hidden = YES;
        desFrame = CGRectMake(10, 2, 300, 88);//修改
    }
    //介绍
    CGFloat desHeight = [noteModel getDescriptionHeight];
    desFrame.size.height = desHeight;
    if (noteModel.description.length > 0) {
        cell.noteDesLabel.frame = desFrame;
        cell.noteDesLabel.text = noteModel.description;
        cell.noteDesLabel.hidden = NO;
    } else {
        cell.noteDesLabel.hidden = YES;
    }
    
    //确定img的坐标
    CGFloat imgHeight = [noteModel getPhotoHeight];
    CGRect imgFrame = CGRectMake(10, desFrame.size.height + 5 + desFrame.origin.y, 300, imgHeight);
    if (noteModel.photo.count > 0) {
        cell.noteImageBtn.frame = imgFrame;
        NSDictionary *photoDict = noteModel.photo;
        [cell.noteImageBtn setImageWithURL:[NSURL URLWithString:[photoDict objectForKey:@"url"]]];
        cell.noteImageBtn.hidden = NO;
    } else {
        cell.noteImageBtn.hidden = YES;
    }
    
    //确定按钮的坐标
    CGRect btnFrame = CGRectMake(28, imgFrame.size.height + 5 +imgFrame.origin.y, 86, 16);
    CGRect locFrame = CGRectMake(10, imgFrame.size.height + 5 +imgFrame.origin.y, 10, 14);    //最下面的按钮
    CGFloat btnHeight = 16;
    cell.noteNameBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    if (nodeModel.entry_name.length > 0) {
        cell.noteNameBtn.frame = btnFrame;
        [cell.noteNameBtn setTitle:nodeModel.entry_name forState:UIControlStateNormal];
        cell.noteNameBtn.hidden = NO;
        cell.noteLocImg.frame = locFrame;
        cell.noteLocImg.hidden = NO;
    } else {
        btnHeight = 0;
        cell.noteNameBtn.hidden = YES;
        cell.noteLocImg.hidden = YES;
    }
    
    cell.noteBottomLabel.frame = CGRectMake(10, btnFrame.origin.y+btnHeight+2, 300, 1);

    return cell;
}

- (CGFloat)getCellHeightWithSection:(NSInteger)section Row:(NSInteger)row
{
    CGFloat height = 0;
    NSArray *dayArray = [self.dataArray objectAtIndex:section];
    TripNoteModel *noteModel =  [dayArray objectAtIndex:row];
    TripNodeModel *nodeModel = noteModel.tripNodeModel;
    if (noteModel.col == 0 && nodeModel.entry_name.length > 0) {
        height += 2+40;
    }
    if (noteModel.description.length > 0) {
        height += 8 + [noteModel getDescriptionHeight];
    }
    if (noteModel.photo.count > 0) {
        height += 5 + [noteModel getPhotoHeight];
    }
    if (nodeModel.entry_name.length > 0) {
        height += 5 + 20;
    }
    height += 4;//底线
    height += 10;
    return height;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *startDate = _model.start_date;
    NSString *nowDate = [LeoDateManager dateStringWithInterVal:60*60*24*section sinceDateStr:startDate inFormat:@"yyyy-MM-dd" toStrWithFormat:@"yyy-MM-dd E"];
    NSInteger currentDay = section+1;
    return [NSString stringWithFormat:@"DAY%d %@", currentDay, nowDate];
}




#pragma mark plan delegated
- (void)planDetailSectionDidSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger rowNow = [[[_nodePositionArray objectAtIndex:section] objectAtIndex:row] intValue];
    
    [self hidePlanDetail];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rowNow inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)planMapButtonClicked
{
    [self hidePlanDetail];
    MapAttractionViewController *map = [[MapAttractionViewController alloc] init];
    map.title = self.model.name;
    map.nodesArray = _planNodesArray;
    [self.navigationController pushViewController:map animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
