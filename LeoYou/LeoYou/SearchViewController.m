//
//  SearchViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-14.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "SearchViewController.h"
#import "NavTabView.h"
#import "TagCell.h"
#import "TripResViewController.h"

@interface SearchViewController () <UITextFieldDelegate, NavTabViewDelegate> {
    UITextField *_searchField;
    NavTabView *_navTabView;
}

@end

@implementation SearchViewController

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
    _navTabView = [[NavTabView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) buttonArray:@[@"国外", @"国内", @"四季"]];
    _navTabView.delegate = self;
    [self.view addSubview:_navTabView];
    
    self.tableView.frame = CGRectMake(0, 40, 320, [DeviceManager screenHeight] - 64 - 49 - 40);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"board" ofType:@"plist"];
    
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:filePath];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createSearchBar];
    _navTabView = [[NavTabView alloc] initWithFrame:CGRectMake(0, 0, 320, 40) buttonArray:@[@"国外", @"国内", @"四季"]];
    _navTabView.delegate = self;
    [self.view addSubview:_navTabView];
    
}

#pragma mark tabNav delegate
- (void)tabBtnClicked:(NSInteger)tag
{
    [self.dataArray removeAllObjects];
    NSArray *fileName = @[@"board", @"china", @"season"];
    NSString *path = [[NSBundle mainBundle] pathForResource:[fileName objectAtIndex:tag] ofType:@"plist"];
    self.dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    [self.tableView reloadData];
}

#pragma tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = [self.dataArray count];
    return (count/3)+(count%3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"tag";
    TagCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TagCell" owner:self options:nil] lastObject];
    }
    [cell.tagLeftBtn setTitle:[self.dataArray objectAtIndex:indexPath.row*3] forState:UIControlStateNormal];
    [cell.tagLeftBtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ((indexPath.row*3+1) < [self.dataArray count]) {
        [cell.tagCenterBtn setTitle:[self.dataArray objectAtIndex:indexPath.row*3 + 1] forState:UIControlStateNormal];
        [cell.tagCenterBtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.tagCenterBtn.hidden = NO;
    } else {
        cell.tagCenterBtn.hidden = YES;
    }

    if ((indexPath.row*3+2) < [self.dataArray count]) {
        [cell.tagRightBtn setTitle:[self.dataArray objectAtIndex:indexPath.row*3 + 2] forState:UIControlStateNormal];
        [cell.tagRightBtn addTarget:self action:@selector(tagBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        cell.tagRightBtn.hidden = NO;
    } else {
        cell.tagRightBtn.hidden = YES;
    }
    
    return cell;
}

- (void)tagBtnClicked:(UIButton *)btn
{
    [self showSearchResultWithKeyWord:btn.titleLabel.text];
}

- (void)showSearchResultWithKeyWord:(NSString*)keyword
{
    TripResViewController *trip = [[TripResViewController alloc] init];
    trip.searchKeyword = keyword;
    [self.navigationController pushViewController:trip animated:YES];
}


- (void)createSearchBar
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    view.backgroundColor = [UIColor clearColor];
    _searchField = [[UITextField alloc] initWithFrame:CGRectMake(0, 5, view.bounds.size.width, 30)];
    
    _searchField.backgroundColor = [UIColor colorWithRed:250/255.0 green:249/255.0 blue:239/255.0 alpha:1];
    [view addSubview:_searchField];
    _searchField.borderStyle = UITextBorderStyleRoundedRect;
    _searchField.clearButtonMode = UITextFieldViewModeAlways;
    _searchField.autocorrectionType = UITextAutocorrectionTypeNo;
    UIImageView *imgview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SearchIcon"]];
    imgview.frame = CGRectMake(10, 0, 18, 18);
    _searchField.leftView = imgview;
    _searchField.leftViewMode = UITextFieldViewModeAlways;
    _searchField.delegate = self;
    self.navigationItem.titleView = view;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_searchField resignFirstResponder];
    [self showSearchResultWithKeyWord:textField.text];
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
