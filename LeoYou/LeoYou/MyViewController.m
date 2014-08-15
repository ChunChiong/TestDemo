//
//  MyViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-7.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "MyViewController.h"
#import "DBManager.h"
#import "TripDetailViewController.h"
#import "TripCell.h"
#import "TripModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "DBManager.h"
#import "PPRevealSideViewController.h"
#import "SettingViewController.h"
@interface MyViewController () <settingViewDelegate>
@end

@implementation MyViewController {
    UILabel *_emptyLabel;
}

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
    self.tableView.frame = CGRectMake(0, 0, 320, [DeviceManager screenHeight]-64-49);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self showCusTabBar];
    [self setCustomTitle:@"我的收藏"];
    [self loadDataWithPage:0];
    self.tableView.editing = NO;
    [self editBtn];
    [self settingBtn];
    _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 40)];
    _emptyLabel.text = @"你还未收藏任何游记...";
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    _emptyLabel.textColor = [UIColor darkGrayColor];
    _emptyLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.view addSubview:_emptyLabel];
    
    [self.view bringSubviewToFront:self.tableView];
    if ([[DBManager sharedManger] getNumOfTrip] <= 0) {
        [self.view bringSubviewToFront:_emptyLabel];
    }
}

//setting按钮被点击的方法
- (void)settingBtnClicked
{
    SettingViewController *setting = [[SettingViewController alloc] init];
    setting.delegate = self;
    [self.revealSideViewController pushViewController:setting onDirection:PPRevealSideDirectionLeft animated:YES];
}

#pragma makr setting的delegate
- (void)clearMineSure
{
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [self.view bringSubviewToFront:_emptyLabel];
}


//editBtn 被点击的方法
- (void)editBtnClicked
{
    self.tableView.editing = !self.tableView.isEditing;
}


//page只是预留的，现在一下获取所有数据
- (void)loadDataWithPage:(NSInteger)page
{
    [self.dataArray removeAllObjects];
    NSArray *array = [[DBManager sharedManger] showAllTrip];
    [self.dataArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

#pragma mark tableView editing的代理
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [self.dataArray removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
    [[DBManager sharedManger] deleteTrip:model];
    if ([[DBManager sharedManger] getNumOfTrip] == 0) {
        [self.view bringSubviewToFront:_emptyLabel];
    }
}


#pragma mark table的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"trip";
    TripCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TripCell" owner:self options:nil] lastObject];
    }
    TripModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.TripBgImageView setImageWithURL:[NSURL URLWithString:model.front_cover_photo_url]];
    [cell.TripUserBtn setImageWithURL:[NSURL URLWithString:[model.user objectForKey:@"image"]]];
    cell.TripNameLabel.text = model.name;
    NSString *info = [NSString stringWithFormat:@"%@|%d天%d图", model.start_date, model.days, model.photos_count];
    cell.TripInfoLabel.text = info;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripModel *model = [self.dataArray objectAtIndex:indexPath.row];
    TripDetailViewController *detail = [[TripDetailViewController alloc] init];
    detail.model = model;
    [self.navigationController pushViewController:detail animated:YES];
}


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    NSLog(@"lalala");
    return YES;
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
