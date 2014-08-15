//
//  FirstShowViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import "FirstShowViewController.h"

#import "AppDelegate.h"
@interface FirstShowViewController ()
{
    UIScrollView*_scrollview;
}
@end

@implementation FirstShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.userInteractionEnabled=YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSUserDefaults *defa=[NSUserDefaults standardUserDefaults];
    [defa setObject:@"first" forKey:@"string"];
    [defa synchronize];
    _scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scrollview.delegate=self;
    _scrollview.contentSize=CGSizeMake(320*3, self.view.bounds.size.height);
    _scrollview.showsHorizontalScrollIndicator=NO;
    _scrollview.showsVerticalScrollIndicator=NO;
    _scrollview.pagingEnabled=YES;
    _scrollview.delegate=self;
    _scrollview.bounces=NO;
    _scrollview.userInteractionEnabled=YES;
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    label.backgroundColor= [UIColor  colorWithRed:80/255.0 green:167/255.0 blue:100/255.0 alpha:1.0];

    
    for (int i=0; i<3; i++) {
        NSString*imagetitle=[NSString stringWithFormat:@"%d",i+1];
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, self.view.bounds.size.height)];
        imageview.image=[UIImage imageNamed:imagetitle];
       
            imageview.userInteractionEnabled=YES;
        if (i==2) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(110, self.view.bounds.size.height-72, 100, 40);
            [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
            [button setImage:[UIImage imageNamed:@"intro_enterBtn_highlighted"] forState:UIControlStateNormal];
            
            [imageview addSubview:button];
            

        }
//
        
        
        [_scrollview addSubview:imageview];
    }
   
    [self.view addSubview:_scrollview];
    [self.view addSubview:label];
}

-(void)buttonclick{
    //展示界面跳转到主界面
    [APPLEGATE showviewcontroller];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
