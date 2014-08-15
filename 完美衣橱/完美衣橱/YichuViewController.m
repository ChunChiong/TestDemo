//
//  YichuViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-11.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "YichuViewController.h"
#import "DeviceManager.h"
#import "FenleiViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SimiViewController.h"
#import "DBManager.h"
#import "YichuModel.h"

@class SimiViewController;

@interface YichuViewController (){
    NSMutableArray *_dataArray;
}
@end

@implementation YichuViewController

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
    //隐藏navigationBar
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"衣橱";
    
    //
    _dataArray = [[NSMutableArray alloc] init];
    NSArray *array = [[DBManager shareManager] fetchAllUsers];
    [_dataArray addObjectsFromArray:array];
    
    //添加自定义的barButton
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_help_new"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(zhidao)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_uploadCloth"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(carmera)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)zhidao
{
    
}

- (void)carmera
{
    [self readyGrayBG:0.7];
    UIButton *carmera = [UIButton buttonWithType:UIButtonTypeCustom];
    carmera.frame = CGRectMake(0, 100, 160, 130);
    carmera.backgroundColor = [UIColor whiteColor];
    [carmera setImage:[[UIImage imageNamed:@"btnUpload_Camera"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    carmera.tag = 101;
    [carmera addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_grayBG addSubview:carmera];

    
    UIButton *libiary = [UIButton buttonWithType:UIButtonTypeCustom];
    libiary.frame = CGRectMake(160, 100, 160, 130);
    libiary.backgroundColor = [UIColor whiteColor];
    [libiary setImage:[[UIImage imageNamed:@"btnUpload_Local"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    libiary.tag = 102;
    [libiary addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_grayBG addSubview:libiary];


    
}

//准备灰色蒙板
-(void)readyGrayBG:(CGFloat)alpha
{
    CGRect grayFrame = [UIApplication sharedApplication].keyWindow.frame;
    grayFrame.origin.x = 0;
    grayFrame.origin.y = 0;
    if(_grayBG == nil)
    {
        _grayBG = [[UIView alloc] initWithFrame:grayFrame];
        //用来接收灰色蒙板点击事件的button
        UIButton *grayClickView = [[UIButton alloc] initWithFrame:grayFrame];
        [grayClickView addTarget:self action:@selector(onGrayBgClick) forControlEvents:UIControlEventTouchUpInside];
        [grayClickView setBackgroundColor:[UIColor clearColor]];
        [_grayBG addSubview:grayClickView];
    }
    else
    {
        [_grayBG removeFromSuperview];
        [_grayBG setFrame:grayFrame];
        //用来接收点击事件的button
        UIView* grayClickView = [[_grayBG subviews] objectAtIndex:0];
        [grayClickView setFrame:grayFrame];
    }
    _grayBG.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    [[UIApplication sharedApplication].keyWindow addSubview:_grayBG];
}
//点击了灰色蒙板
-(void)onGrayBgClick
{
    [_grayBG removeFromSuperview];
}


- (void)takePhoto:(UIButton *)btn
{
    [_grayBG removeFromSuperview];
    UIImagePickerController *piker = [[UIImagePickerController alloc] init];
    if(btn.tag == 101){
    piker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        piker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    piker.delegate = self;
    piker.allowsEditing = YES;
    [self presentViewController:piker animated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    //拿到资源类型
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //如果是图片资源类型，进行后续操作
    //kUTTypeImage 系统定义的 代表图片资源类型的常量
    UIImage *image = [[UIImage alloc] init];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取选中的图片
image = [info objectForKey:UIImagePickerControllerEditedImage];

    }
    
    FenleiViewController *flv = [[FenleiViewController alloc] init];
    //UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:flv];
    
//    [picker presentViewController:nc animated:YES completion:^{
//       // [flv.imageView setImage:image];
//
//}];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.navigationController pushViewController:flv animated:YES];
        flv.image = image;
    }];

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userCell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
    
    YichuModel *model = [[YichuModel alloc] init];
    model = [_dataArray objectAtIndex:indexPath.row];
    NSLog(@"%@%@%@",model.Image,model.price,model.sortName);
    [cell.imageView setImage:model.Image];
    cell.textLabel.text = model.sortName;

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
