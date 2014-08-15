//
//  RijiViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-17.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "RijiViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "RijiXiangqingViewController.h"


@interface RijiViewController (){
    NSInteger _currentYear;
    NSInteger _currentMonth;
    NSInteger _NowYear;
    NSInteger _NowMonth;
    NSDateFormatter *format;
    UIImage *btnImage;
}

@end

@implementation RijiViewController

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
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"穿衣日记";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    //
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_uploadCloth"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(carmera)];
    
    self.navigationItem.rightBarButtonItem = item1;
    
   
    
    
    //初始化日历
    myCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //设置没周的第一天从星期几开始 设置1为周日 2为周一
    [myCalendar setFirstWeekday:1];
    
    [myCalendar setMinimumDaysInFirstWeek:1];
    
    [myCalendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:0]];
    [self calendarSetDate:[NSDate date]];
    
    format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger seconds = [zone secondsFromGMT];
    NSDate *localDate = [NSDate dateWithTimeInterval:seconds sinceDate:date];
    NSString *str = [format stringFromDate:localDate];
    NSArray *array = [str componentsSeparatedByString:@"-"];
    
    _currentYear = [[NSString stringWithFormat:@"%@",array[0]] integerValue];
    _currentMonth = [[NSString stringWithFormat:@"%@",array[1]] integerValue];
    _NowYear = [[NSString stringWithFormat:@"%@",array[0]] integerValue];
    _NowMonth = [[NSString stringWithFormat:@"%@",array[1]] integerValue];


    
    
}
//实现camera方法
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

#pragma mark imagePickerdelegate

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
        btnImage = image;
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self reloadCalender];

    }];
    
    
}



- (void)calendarSetDate:(NSDate *)date
{
    monthRange = [myCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    //monthRange.length date里的月份有多少天
    //NSLog(@"monthRange : %d %d",monthRange.location,monthRange.length);
    currentDayIndexOfMonth = [myCalendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    //返回的是date 里的日期是在这个月的第几天
   // NSLog(@"currentIndex:%d",currentDayIndexOfMonth);
    
    NSTimeInterval interval;
    NSDate *firstDayOfMonth;
    if ([myCalendar rangeOfUnit:NSMonthCalendarUnit startDate:&firstDayOfMonth interval:&interval forDate:date]) {
        //NSLog(@"%@",firstDayOfMonth);
        //NSLog(@"%f",interval);
    }
    //获取date所在月的第一天在其所在周的位置，即第几天
    firstDayIndexOfWeek = [myCalendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:firstDayOfMonth];
    
    //画按钮
    [self drawBtn];
    
}

- (void)drawBtn
{
    for (int i = firstDayIndexOfWeek - 1; i<monthRange.length + firstDayIndexOfWeek - 1; i ++) {

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[btn setBackgroundImage:[UIImage imageNamed:@"btn_headImgBg"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(5,5,12,12);
        
        btn.tag = i + 2 - firstDayIndexOfWeek;
        
        [btn setTitle:[NSString stringWithFormat:@"%d",i+2-firstDayIndexOfWeek] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.titleLabel.textColor = [UIColor blackColor];

        if (btn.tag == currentDayIndexOfMonth) {
            btn.titleLabel.textColor = [UIColor redColor];
        }
        
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn2.frame = CGRectMake(2, 15, 40, 35);
        btn2.tag = 200 + i + 2 - firstDayIndexOfWeek;
        if ((btn2.tag - 200)==currentDayIndexOfMonth&&_NowMonth == _currentMonth&&_NowYear == _currentYear) {
            [btn2 setBackgroundImage:btnImage forState:UIControlStateNormal];
        }
        

        [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(6+44*(i%7), 150 + 54*(i/7), 44, 54)];
        imageview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_headImgBg"]];
        imageview.tag = 100+ i + 2 - firstDayIndexOfWeek;
        imageview.userInteractionEnabled = YES;
        [imageview addSubview:btn];
        [imageview addSubview:btn2];

        [self.view addSubview:imageview];
    }
}

- (void)btnClick:(UIButton *)btn
{
    RijiXiangqingViewController *rjx= [[RijiXiangqingViewController alloc] init];
    if((btn.tag - 200)==currentDayIndexOfMonth&&_NowMonth == _currentMonth&&_NowYear == _currentYear){
    rjx.image = btnImage;
    }
    rjx.btntitle = [NSString stringWithFormat:@"%d-%d-%d",_currentYear,_currentMonth,(btn.tag-200)];
    [self.navigationController pushViewController:rjx animated:YES];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)yearAddClick:(UIButton *)sender {
    _currentYear ++;
    _yearLabel.text = [NSString stringWithFormat:@"%d",_currentYear];
    [self reloadCalender];

}

- (IBAction)yearReduceClick:(UIButton *)sender {
    _currentYear--;
    _yearLabel.text = [NSString stringWithFormat:@"%d",_currentYear];
    [self reloadCalender];

}

- (IBAction)monthAdd:(UIButton *)sender {
    if (_currentMonth<12) {
        _currentMonth ++;
    }else{
        _currentMonth = 1;
        _currentYear ++;
    }
    _monthLabel.text = [NSString stringWithFormat:@"%d",_currentMonth];
    _yearLabel.text = [NSString stringWithFormat:@"%d",_currentYear];
    [self reloadCalender];

}

- (IBAction)monthReduce:(UIButton *)sender {
    if(_currentMonth>1){
    _currentMonth --;
    }else{
        _currentMonth = 12;
        _currentYear -- ;
        
    }
    _monthLabel.text = [NSString stringWithFormat:@"%d",_currentMonth];
    _yearLabel.text = [NSString stringWithFormat:@"%d",_currentYear];
    [self reloadCalender];

}

- (void)reloadCalender
{
    NSString *str = [NSString stringWithFormat:@"%d-%d-%d",_currentYear,_currentMonth,currentDayIndexOfMonth];
    NSDate *date = [format dateFromString:str];
    for (int i = 1; i<=monthRange.length; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        [button removeFromSuperview];
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:100+i];
        [imageView removeFromSuperview];
        UIButton *button1 = (UIButton *)[self.view viewWithTag:200+i];
        [button1 removeFromSuperview];

    }
    [self calendarSetDate:date];
}
@end
