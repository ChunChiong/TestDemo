//
//  DapeizhidaoViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-17.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "DapeizhidaoViewController.h"
//#import "SVProgressHUD.h"

@interface DapeizhidaoViewController (){
    UIWebView *_webView;
}

@end

@implementation DapeizhidaoViewController

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
    self.navigationItem.title = @"搭配指导";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    CGRect rect = _webView.frame;
    rect.size.height = rect.size.height+49;
    _webView.frame = rect;
    NSURL *url = [NSURL URLWithString:@"http://www.wanmeiyichu.com/help/style_help.html"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate =self;
    [self.view addSubview:_webView];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //[SVProgressHUD showInView:self.view status:@"正在加载"];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[SVProgressHUD dismiss];
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
