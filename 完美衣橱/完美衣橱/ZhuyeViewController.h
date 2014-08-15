//
//  ZhuyeViewController.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-8.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "ParentsViewController.h"

@interface ZhuyeViewController : ParentsViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *FansLabel;
@property (weak, nonatomic) IBOutlet UILabel *focusLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewedLabel;
@property (weak, nonatomic) IBOutlet UILabel *shaishaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangcaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *huodongLabel;
@property (weak, nonatomic) IBOutlet UILabel *ChengjiuLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhidaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *fengshangLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangTaiLabel;
- (IBAction)CameraButtonClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *LevelLabel;
- (IBAction)HeaderImageButtonClick:(UIButton *)sender;
- (IBAction)ShaiBtnClick:(UIButton *)sender;
- (IBAction)ZhuanBtnClick:(UIButton *)sender;

@end
