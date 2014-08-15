//
//  ZhuyeViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-8.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "ZhuyeViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+AFNetworking.h"
#import "ShaiViewController.h"

@interface ZhuyeViewController ()

@end
#define kZhuYeUrlString @"http://open.wanmeiyichu.com/api/member.getHome?uid=254512&key=e9ca2033904e333acfb1e3bd74d7ca09&member_uid=254512"

@implementation ZhuyeViewController{
    NSInteger Type;
}

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
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden = YES;
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    [manager POST:kZhuYeUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *subDic = [responseObject objectForKey:@"data"];
        [_backgroundImageView setImageWithURL:[NSURL URLWithString:[subDic objectForKey:@"background"]]];
        [_headerImageView setImageWithURL:[NSURL URLWithString:[subDic objectForKey:@"avatar"]]];
        _FansLabel.text = [subDic objectForKey:@"follower_count"];
        _focusLabel.text = [subDic objectForKey:@"following_count"];
        NSNumber *number =[subDic objectForKey:@"member_viewed_count"];
        //要看解析出数据的类型
       _viewedLabel.text = [number stringValue];
        
        _LevelLabel.text = [subDic objectForKey:@"member_level"];
        _zhuangTaiLabel.text = [subDic objectForKey:@"introduction"];
        _shaishaiLabel.text = [NSString stringWithFormat:@"晒晒(%@)",[subDic objectForKey:@"dressShowCount"]];
        _zhuangcaiLabel.text = [NSString stringWithFormat:@"转采(%@)",[subDic objectForKey:@"forwards_count"]];
        _huodongLabel.text = [NSString stringWithFormat:@"活动(%@)",[subDic objectForKey:@"activity_count"]];
        _ChengjiuLabel.text = [NSString stringWithFormat:@"成就(%@)",[subDic objectForKey:@"achievement_count"]];
        _zhidaoLabel.text = [NSString stringWithFormat:@"知道(%@)",[subDic objectForKey:@"know_answer_count"]];
        _fengshangLabel.text = [NSString stringWithFormat:@"风尚(%@)",[subDic objectForKey:@"fashion_count"]];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error : %@",error.localizedDescription);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)CameraButtonClick:(UIButton *)sender {
    Type = 0;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
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
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取选中的图片
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        //
        if (Type==0) {
            [_backgroundImageView setImage:image];
        }else{
            [_headerImageView setImage:image];
        }
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (IBAction)HeaderImageButtonClick:(UIButton *)sender {
    Type = 1;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];

}

- (IBAction)ShaiBtnClick:(UIButton *)sender {
    ShaiViewController *sv = [[ShaiViewController alloc] init];
    [self.navigationController pushViewController:sv animated:YES];
}

- (IBAction)ZhuanBtnClick:(UIButton *)sender {
}
@end
