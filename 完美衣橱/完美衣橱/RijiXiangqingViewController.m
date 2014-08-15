//
//  RijiXiangqingViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-22.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "RijiXiangqingViewController.h"

@interface RijiXiangqingViewController ()

@end

@implementation RijiXiangqingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _btntitle;
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageview.image = _image;
    [self.view addSubview:imageview];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
