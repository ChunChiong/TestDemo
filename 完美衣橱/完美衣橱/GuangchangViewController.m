//
//  GuangchangViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "GuangchangViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "DeviceManager.h"
#import "UIImageView+AFNetworking.h"
#import "ShaishaiViewController.h"

@interface GuangchangViewController (){
    UIPageControl *_pageControl;
}

#define kGuangchangUrlString @"http://open.wanmeiyichu.com/api/banner.getList?uid=254512&key=e9ca2033904e333acfb1e3bd74d7ca09&sign=f2756576f04db75e4ece8cdff302599b&timestamp=1405998476"

@end

@implementation GuangchangViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //加入此属性sceolloerView则会不会弹性滑动
        self.automaticallyAdjustsScrollViewInsets = NO;
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
    self.navigationController.navigationBarHidden = YES;
    CGFloat h = [DeviceManager currentScreenHeight]-20*2-44;
    UIScrollView *scollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,20 ,320,h/2)];
    scollerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"banner_bg"]];
    scollerView.bounces = NO;

    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init]; 
//    //将现在时间改为时间戳
//    NSDate *datenow = [NSDate date];
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//    NSLog(@"---------%@",timeSp);
    [manager POST:kGuangchangUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *subDict = [responseObject objectForKey:@"data"];
        NSArray *array = [subDict objectForKey:@"reqdata"];
        for (int i=0; i<array.count; i++) {
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320,scollerView.bounds.size.height)];
            [view setImageWithURL:[NSURL URLWithString:[array[i] objectForKey:@"banner_photo_url"]]];
            [scollerView addSubview:view];
        }
        scollerView.contentSize = CGSizeMake(320*array.count,scollerView.bounds.size.height);
        scollerView.showsHorizontalScrollIndicator = NO;
        scollerView.showsVerticalScrollIndicator = NO;
        scollerView.pagingEnabled = YES;
        scollerView.delegate = self;
        
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(160, scollerView.bounds.size.height, 160, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = array.count;
        _pageControl.currentPageIndicatorTintColor =[UIColor colorWithRed:233/255.0 green:114/255.0 blue:182/255.0 alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        [self.view addSubview:_pageControl];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error : %@",error.localizedDescription);
    }];
    
    [self.view addSubview:scollerView];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, h/2+20+10, (300-10)/2, (h-20)/3);
    [button1 setBackgroundImage:[UIImage imageNamed:@"squareCell_share"] forState:UIControlStateNormal];
    button1.tag = 101;
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(10+button1.bounds.size.width+10, h/2+20+10, (300-10)/2, ((h-20)/3-10)/2);
    [button2 setBackgroundImage:[UIImage imageNamed:@"squareCell_know"] forState:UIControlStateNormal];
    button2.tag = 102;
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(10+button1.bounds.size.width+10, h/2+20+10+10+button2.bounds.size.height, (300-10)/2, ((h-20)/3-10)/2);
    [button3 setBackgroundImage:[UIImage imageNamed:@"squareCell_activity"] forState:UIControlStateNormal];
    button3.tag = 103;
    [button3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    NSArray *imageArray = @[@"squareCell_brand",@"squareCell_designer",@"squareCell_star",@"squareCell_Vogue"];
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat Xspace = (320-5*10)/4;
        button.frame = CGRectMake((Xspace+10)*i+10, h/2+20+10+10+button1.bounds.size.height, Xspace, (h/2-10)/3);
        [button setBackgroundImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        button.tag = 104+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    
}

- (void)buttonClick:(UIButton *)button
{
    switch (button.tag) {
        case 101:
        {
            ShaishaiViewController *sv = [[ShaishaiViewController alloc] init];
            [self.navigationController pushViewController:sv animated:YES];


        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:
        {
            
        }
            break;
        case 106:
        {
            
        }
            break;
        case 107:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/320;
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
