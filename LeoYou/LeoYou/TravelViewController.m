//
//  TravelViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-10.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "TravelViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "TravalModel.h"
#import "TravelCell.h"
#import "UIImageView+WebCache.h"
#import "HttpRequestManager.h"
#import "PlansViewController.h"

@interface TravelViewController () <HttpRequestManagerDelegate>{
    HttpRequestManager *_httpRequest;
}

@end

@implementation TravelViewController

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
    
    _httpRequest = [[HttpRequestManager alloc] init];
    _httpRequest.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customBackBtn];
    [self setCustomTitle:@"行程"];
    [self loadDataWithPage:1];
}

- (void)loadDataWithPage:(NSInteger)page
{
    [self.dataArray removeAllObjects];
    NSString *urlStr = [NSString stringWithFormat:kURLTraval, self.travalID, page];
    [_httpRequest requestDataWithURLStr:urlStr];
}

#pragma mark httpRequest delegate
- (void)httpLoadDataFailed:(NSString *)error
{
    NSLog(@"error:%@", error);
}

- (void)httpLoadDataSuccess:(id)data
{
    if ([data isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in data) {
            TravalModel *model = [[TravalModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            model.travelID = [[dict objectForKey:@"id"] integerValue];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
    }
}



#pragma mark table view delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", [self.dataArray count]);
    return [self.dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 185.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"travel";
    TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TravelCell" owner:self options:nil] lastObject];
    }
    TravalModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.travelDayLabel.text = [NSString stringWithFormat:@"%d天", model.plan_days_count];
    cell.travelDesLabel.text = [NSString stringWithFormat:@"%d个旅行地", model.plan_nodes_count];
    cell.travelTitlelabel.text = model.name;
    [cell.travelmageView setImageWithURL:[NSURL URLWithString:model.image_url]];
    cell.travelDetailLabel.text = model.description;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TravalModel *travel = [self.dataArray objectAtIndex:indexPath.row];
    PlansViewController *plan = [[PlansViewController alloc] init];
    plan.travel = travel;
    [self.navigationController pushViewController:plan animated:YES];
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
