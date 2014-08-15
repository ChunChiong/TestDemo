//
//  YichuTongjiViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-11.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "YichuTongjiViewController.h"
#import "TongjiCell.h"

@interface YichuTongjiViewController ()

@end

@implementation YichuTongjiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return self;
}

//隐藏自定义tabBar
- (void)viewWillAppear:(BOOL)animated
{
    [[self.tabBarController.view.subviews lastObject] setHidden:YES];
    
}

//显示自定义TabBar
- (void)viewWillDisappear:(BOOL)animated{
    [[self.tabBarController.view.subviews lastObject] setHidden:NO];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"衣橱统计";

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TongjiCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000.f;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userCell = @"Cell";
    TongjiCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
    
    return cell;
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
