//
//  ShaishaiViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-16.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "ShaishaiViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface ShaishaiViewController ()

#define kShaiUrlString @"http://open.wanmeiyichu.com/api/flow.getListByType?sign=84cbe709df87990274e34248440f282c&timestamp=1405510338&flow_type=0&pagesize=30&pg=1&type=3&class=1&sort=1&size=190x0"

@end

@implementation ShaishaiViewController



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
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"晒晒";
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager POST:kShaiUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject : %@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
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
