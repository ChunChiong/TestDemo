//
//  SimiViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "SimiViewController.h"
#import "DeviceManager.h"
#import "YichuViewController.h"
#import "YichuSearchViewController.h"
#import "YichuTongjiViewController.h"
#import "DapeiViewController.h"
#import "RijiViewController.h"

@interface SimiViewController ()

@end

@implementation SimiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.backgroundColor = [UIColor colorWithRed:148/255.0 green:202/255.0 blue:202/255.0 alpha:1];
    btn1.frame = CGRectMake(10, 25, 300, 30);
    btn1.tag = 200;
    [btn1 setTitle:@"同步：数据完整暂无需同步" forState:UIControlStateNormal];
    btn1.tintColor = [UIColor whiteColor];
    [self.view addSubview:btn1];
    
//button类型要是UIButtonTypeCustom，他的image才不会是一个色块
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(10, 65,(320-30)/2 ,([DeviceManager currentScreenHeight]-44-65-20)/2);
    btn2.backgroundColor = [UIColor colorWithRed:245/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [btn2 setImage:[UIImage imageNamed:@"Yichu_Icon_0"] forState:UIControlStateNormal];
    btn2.tag = 100;
    [btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(10, 65+btn2.frame.size.height+10,(320-30)/2 ,([DeviceManager currentScreenHeight]-44-65-20)/2);
    btn3.backgroundColor =[UIColor colorWithRed:245/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [btn3 setImage:[UIImage imageNamed:@"Yichu_Icon_3"] forState:UIControlStateNormal];
    btn3.tag = 103;
    [btn3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(10+10+btn2.frame.size.width, 65+btn2.frame.size.height+10,(320-30)/2 ,([DeviceManager currentScreenHeight]-44-65-20)/2);
    btn4.backgroundColor = [UIColor colorWithRed:245/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [btn4 setImage:[UIImage imageNamed:@"Yichu_Icon_4"] forState:UIControlStateNormal];
    btn4.tag = 104;
    [btn4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn5.frame = CGRectMake(10+10+btn2.frame.size.width, 65,(320-30)/2 ,(btn2.frame.size.height-10)/2);
    btn5.backgroundColor = [UIColor colorWithRed:245/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [btn5 setImage:[UIImage imageNamed:@"Yichu_Icon_1"] forState:UIControlStateNormal];
    btn5.tag = 101;
    [btn5 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];

    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn6.frame = CGRectMake(10+10+btn2.frame.size.width, 65+10+btn5.frame.size.height,(320-30)/2 ,(btn2.frame.size.height-10)/2);
    btn6.backgroundColor = [UIColor colorWithRed:245/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [btn6 setImage:[UIImage imageNamed:@"Yichu_Icon_2"] forState:UIControlStateNormal];
    btn6.tag = 102;
    [btn6 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn6];


    
}


- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case 100:
        {
            YichuViewController *yv = [[YichuViewController alloc] init];
            [self.navigationController pushViewController:yv animated:YES];
        }
            break;
        case 101:
        {
            
            YichuSearchViewController *ycs = [[YichuSearchViewController alloc] init];
            [self.navigationController pushViewController:ycs animated:YES];
        }
            break;
        case 102:
        {
            YichuTongjiViewController *yct = [[YichuTongjiViewController alloc] init];
            [self.navigationController pushViewController:yct animated:YES];
        }
            break;
        case 103:
        {
            DapeiViewController *dv = [[DapeiViewController alloc] init];
            [self.navigationController pushViewController:dv animated:YES];
        }
            break;
        case 104:
        {
            RijiViewController *rv = [[RijiViewController alloc] init];
            [self.navigationController pushViewController:rv animated:YES];
        }
            break;
        case 200:
        {
            
        }
            break;
            
        default:
            break;
    }
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
