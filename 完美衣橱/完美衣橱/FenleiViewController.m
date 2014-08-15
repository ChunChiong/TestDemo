//
//  FenleiViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-15.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "FenleiViewController.h"
#import "YichuViewController.h"
#import "YichuModel.h"
#import "DBManager.h"

@interface FenleiViewController (){
    UITextField *sortTextField;
    UITextField *priceTextField;
}

@end

@implementation FenleiViewController

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
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 100, 100)];
    _imageView.image = _image;
    [self.view addSubview:_imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 50, 50)];
    label.text = @"分类:";
    [self.view addSubview:label];
    
    sortTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 200, 200, 50)];
    sortTextField.placeholder = @"请输入衣服种类";
    [self.view addSubview:sortTextField];
    
    UILabel *pricelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 50, 50)];
    pricelabel.text = @"价格:";
    [self.view addSubview:pricelabel];
    
    priceTextField = [[UITextField alloc] initWithFrame:CGRectMake(70, 260, 200, 50)];
    priceTextField.placeholder = @"请输入衣服价格";
    [self.view addSubview:priceTextField];

    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    
}


- (void)back
{
    YichuViewController *yc = [[YichuViewController alloc]init];
    [self.navigationController pushViewController:yc animated:YES];
    //[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)save
{
    if(sortTextField.text.length == 0|| priceTextField.text.length == 0){
        NSLog(@"信息不全");
        return;
    }

    _model = [[YichuModel alloc] init];
    _model.sortName = sortTextField.text;
    _model.price = priceTextField.text;
    _model.Image = _image;

    [[DBManager shareManager] insertDataWithModel:_model];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)fenlei
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 220, 300)];
    
    
    [self.view addSubview:view];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [sortTextField resignFirstResponder];
    [priceTextField resignFirstResponder];
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
