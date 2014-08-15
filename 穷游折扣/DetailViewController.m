//
//  DetailViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import "DetailViewController.h"
#import "MyNavigationBar.h"
#import "DeviceManager.h"
#import "SVProgressHUD.h"
#import "ShowViewController.h"
#import "ShareActionSheet.h"
#import "AWActionSheet.h"
#import "SafeDBManager.h"
#import "LoginViewController.h"
#import "MyCollectionViewController.h"


@interface DetailViewController ()<UIActionSheetDelegate,AWActionSheetDelegate,UIAlertViewDelegate>{
    UIWebView*_webView;
    UILabel *_label2;
    NSTimer *_time;
    MyNavigationBar *_mnb;
}

@end

@implementation DetailViewController

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
    self.navigationController.navigationBarHidden = YES;
    [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
    NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
    UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
    NSString *loginName = sinaAccount.userName;
    _mnb=[[MyNavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    if ([[SafeDBManager shareManager]isCollectedWithOutlineID:self.model.outlineID withLoginName:loginName]) {
        [_mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"折扣详情" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_webview_back"] andRigtBBIImageName:@[@"nav_btn_liked_highlighted",@"nav_btn_share_highlighted"] andClass:self andSEL:@selector(bbiClick:)];
    }else{
        [_mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"折扣详情" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_webview_back"] andRigtBBIImageName:@[@"nav_btn_like_highlighted",@"nav_btn_share_highlighted"] andClass:self andSEL:@selector(bbiClick:)];
    }
    
    
    [self.view addSubview:_mnb];
    [self createWebView];
    [self  createToolBarUI];
    _time=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeClick) userInfo:nil repeats:YES];

}

-(void)createWebView{
    NSInteger height=[DeviceManager currentScreenHeight];
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, 320, height-64-49)];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:kDetailUrl,self.model.outlineID]]];
    [_webView loadRequest:request];
    _webView.delegate=self;
    [self.view addSubview:_webView];
}

-(void)bbiClick:(UIButton *)button{
    if (button.tag==200) {
        if (self.flag==0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            MyCollectionViewController *mvc = [[MyCollectionViewController alloc]init];
            UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:mvc];
            [self.revealSideViewController popViewControllerWithNewCenterController:nc animated:YES];
        }
        
    }else if (button.tag==301){
        AWActionSheet *as = [[AWActionSheet alloc]initwithIconSheetDelegate:self ItemCount:[self numberOfItemsInActionSheet]];
        [as showInView:self.view];
    }else if (button.tag==300){
        [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
        NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
        UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:UMShareToSina];
        NSString *loginName = sinaAccount.userName;
        BOOL isOauth = [UMSocialAccountManager isOauthAndTokenNotExpired:UMShareToSina];
        if (isOauth) {
            if ([[SafeDBManager shareManager]isCollectedWithOutlineID:self.model.outlineID withLoginName:loginName]) {
                [_mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"折扣详情" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_webview_back"] andRigtBBIImageName:@[@"nav_btn_like_highlighted",@"nav_btn_share_highlighted"] andClass:self andSEL:@selector(bbiClick:)];
                [[SafeDBManager shareManager]deleteDataWithOutlineID:self.model.outlineID withLoginName:loginName];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"删除成功" message:@"您已成功删除该条收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            } else {
                [_mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:@"折扣详情" andTitleImageName:Nil andLeftBBIImageName:@[@"btn_webview_back"] andRigtBBIImageName:@[@"nav_btn_liked_highlighted",@"nav_btn_share_highlighted"] andClass:self andSEL:@selector(bbiClick:)];
                [[SafeDBManager shareManager]insertDataWithModel:self.model withLoginName:loginName];
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"添加成功" message:@"您已成功添加该条收藏" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"未登录" message:@"亲，您尚未登陆" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            LoginViewController *lvc = [[LoginViewController alloc]init];
            UINavigationController *n = [[UINavigationController alloc]initWithRootViewController:lvc];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        }
        
    }
}

-(int)numberOfItemsInActionSheet
{
    return 6;
}


-(AWActionSheetCell *)cellForActionAtIndex:(NSInteger)index
{
    AWActionSheetCell* cell = [[AWActionSheetCell alloc] init];
    NSArray *actionSheetIconArray=@[@"util_btn_actionsheet_weibo",@"util_btn_actionsheet_weixin",@"util_btn_actionsheet_friend",@"util_btn_actionsheet_qzone",@"util_btn_actionsheet_mail",@"util_btn_actionsheet_message"];
    NSArray *actionSheetTitleArray = @[@"新浪微博",@"微信",@"微信朋友圈",@"Qzone",@"邮件",@"短信"];
    [[cell iconView] setImage:[UIImage imageNamed:actionSheetIconArray[index]]];
    [[cell titleLabel] setText:actionSheetTitleArray[index]];
    cell.index = index;
    return cell;
}

-(void)DidTapOnItemAtIndex:(NSInteger)index
{
    [UMSocialData setAppKey:@"53b75b0756240b45eb081eb3"];
    if (index==0) {
        [[UMSocialControllerService defaultControllerService] setShareText:[NSString stringWithFormat:@"我发现【%@】真的好划算%@",self.model.title,self.model.url]  shareImage:[UIImage imageNamed:@"share_image.jpg"] socialUIDelegate:self];
        //设置分享内容和回调对象
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }else if (index==1){
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:[NSString stringWithFormat:@"我发现【%@】真的好划算%@",self.model.title,self.model.url] image:[UIImage imageNamed:@"share_image.jpg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"成功" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];
    }else if (index==2){
        //UMShareToWechatTimeline
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:[NSString stringWithFormat:@"我发现【%@】真的好划算%@",self.model.title,self.model.url] image:[UIImage imageNamed:@"share_image.jpg"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"成功" message:@"分享成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
            }
        }];

    }else if (index==3){
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"53b75b0756240b45eb081eb3"  shareText: [NSString stringWithFormat:@"我发现【%@】真的好划算%@",self.model.title,self.model.url] shareImage:[UIImage imageNamed:@"share_image.jpg"] shareToSnsNames:[NSArray arrayWithObjects:UMShareToQzone,nil] delegate:self];
    }else if (index==4){
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc]init];
        if ([MFMailComposeViewController canSendMail]) {
            [mailController setSubject:[NSString stringWithFormat:@"我发现【%@】真的好划算%@",self.model.title,self.model.url]];
            [mailController setMessageBody:self.model.detail isHTML:YES];
            mailController.mailComposeDelegate = self;
            UIImage *image = [UIImage imageNamed:@"share_image.jpg"];
            NSData *data = UIImageJPEGRepresentation(image,1.0);
            [mailController addAttachmentData:data mimeType:@"file/jpg" fileName:@"share_image.jpg"];
            [self presentViewController:mailController animated:YES completion:^{
                
            }];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"您的手机无此功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }else{
        MFMessageComposeViewController *message = [[MFMessageComposeViewController alloc]init];
        if ([MFMessageComposeViewController canSendText]) {
            message.body = [NSString stringWithFormat:@"我发现【%@】真的好划算%@",self.model.title,self.model.url];
            message.recipients = [NSArray arrayWithObjects:@"", nil];
            message.messageComposeDelegate = self;
            [self presentViewController:message animated:YES completion:^{
                
            }];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"您的手机无此功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
   
}


-(void)createToolBarUI{
    NSInteger heigh=[DeviceManager currentScreenHeight];
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, heigh-49,320 , 49)];
    imageview.userInteractionEnabled=YES;
    [self.view addSubview:imageview];
    UILabel *label=[[UILabel alloc]initWithFrame:imageview.bounds];
    label.backgroundColor=[UIColor whiteColor];
    [imageview addSubview:label];

    if ([self.scroll isEqualToString:@"yes"]) {
        
    }else{
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(5, 4.5, 150, 20)];
    label1.font=[UIFont systemFontOfSize:12];
    label1.text=@"离折扣结束还有";
    [imageview addSubview:label1];
    _label2=[[UILabel alloc]initWithFrame:CGRectMake(5, 24.5, 150, 20)];
    //结束时间
    NSMutableArray *lastTimeArray=[[NSMutableArray alloc]init];
    NSDate *date=[NSDate date];
    if ([self.model.end_date rangeOfString:@"."].location!=NSNotFound) {
        NSString *FirstTimeString=[[self.model.end_date componentsSeparatedByString:@"结"] objectAtIndex:0];
        NSArray *TimeArray=[FirstTimeString componentsSeparatedByString:@"."];
        //当前时间
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd hh-mm-ss"];
        NSString *String=[dateFormater stringFromDate:date];
        NSArray *array=[String componentsSeparatedByString:@" "];
        NSArray *array1=[[array objectAtIndex:0] componentsSeparatedByString:@"-"];
        NSString *firstString=[TimeArray objectAtIndex:2];
        NSInteger first=firstString.integerValue;
        NSString*lastString=[array1 objectAtIndex:2];
        NSInteger last=lastString.integerValue;
        NSString *firstString1=[TimeArray objectAtIndex:1];
        NSInteger first1=firstString1.integerValue;
        NSString*lastString1=[array1 objectAtIndex:1];
        NSInteger last1=lastString1.integerValue;
        if (first<last) {
            first+=31;
            first1-=1;
        }
        
        NSInteger day=first-last;
        NSInteger day1=first1-last1;
        NSString *mounth=[NSString stringWithFormat:@"%d",day1];
        [lastTimeArray addObject:mounth];
        [lastTimeArray addObject:[NSString stringWithFormat:@"月"]];
        
        NSString *daystring=[NSString stringWithFormat:@"%d",day];
        [lastTimeArray addObject:daystring];
        [lastTimeArray addObject:[NSString stringWithFormat:@"天"]];
    }else{
        [lastTimeArray addObject:[NSString stringWithFormat:@"%d",0]];
        [lastTimeArray addObject:@"天"];
        NSString *string=[[self.model.end_date componentsSeparatedByString:@"还有"]lastObject ];
        string=[[string componentsSeparatedByString:@"天"]objectAtIndex:0];
        [lastTimeArray addObject:string];
        [lastTimeArray addObject:@"月"];
    }
    NSDate*mDate=[NSDate dateWithTimeIntervalSince1970:[self.model.firstpay_end_time integerValue]];
    NSTimeInterval timeInval=[mDate timeIntervalSinceDate:date];

    NSInteger day2=(int)timeInval/86400;
    NSInteger hour=((int)timeInval-day2*86400)/3600;
    NSInteger minute=((int)timeInval-day2*86400-hour*3600)/60;
    NSInteger second=(int)timeInval-day2*86400-hour*3600-minute*60;
    NSString *Fhour=[NSString stringWithFormat:@"%02d",hour];
    NSString *Fminute=[NSString stringWithFormat:@"%02d",minute];
    NSString *Fsecond=[NSString stringWithFormat:@"%02d",second];
    
    [lastTimeArray addObjectsFromArray:@[Fhour,@"时",Fminute,@"分",Fsecond,@"秒"]];
    NSString *label2text=[lastTimeArray componentsJoinedByString:@""];
    _label2.text=label2text;
    
    _label2.font=[UIFont systemFontOfSize:12];
    [imageview addSubview:_label2];
    }
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(181, 10, 134, 29);
    
    [button addTarget:self action:@selector(Toolbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitle:@"在线预定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    [imageview addSubview:button];
    
}

#pragma mark-time
-(void)timeClick{
    NSMutableArray *lastTimeArray=[[NSMutableArray alloc]init];
    NSDate *date=[NSDate date];
    if ([self.model.end_date rangeOfString:@"."].location!=NSNotFound) {
        NSString *FirstTimeString=[[self.model.end_date componentsSeparatedByString:@"结"] objectAtIndex:0];
        NSArray *TimeArray=[FirstTimeString componentsSeparatedByString:@"."];
        
        //当前时间
        NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyyy-MM-dd hh-mm-ss"];
        NSString *String=[dateFormater stringFromDate:date];
        NSArray *array=[String componentsSeparatedByString:@" "];
        NSArray *array1=[[array objectAtIndex:0] componentsSeparatedByString:@"-"];
        NSString *firstString=[TimeArray objectAtIndex:2];
        NSInteger first=firstString.integerValue;
        NSString*lastString=[array1 objectAtIndex:2];
        NSInteger last=lastString.integerValue;
        NSString *firstString1=[TimeArray objectAtIndex:1];
        NSInteger first1=firstString1.integerValue;
        NSString*lastString1=[array1 objectAtIndex:1];
        NSInteger last1=lastString1.integerValue;
        if (first<last) {
            first+=31;
            first1-=1;
        }
        NSInteger day=first-last;
        NSInteger day1=first1-last1;
        NSString *mounth=[NSString stringWithFormat:@"%d",day1];
        [lastTimeArray addObject:mounth];
        [lastTimeArray addObject:[NSString stringWithFormat:@"月"]];
        
        NSString *daystring=[NSString stringWithFormat:@"%d",day];
        [lastTimeArray addObject:daystring];
        [lastTimeArray addObject:[NSString stringWithFormat:@"天"]];
    }else{
        [lastTimeArray addObject:[NSString stringWithFormat:@"%d",0]];
        [lastTimeArray addObject:@"月"];
        NSString *string=[[self.model.end_date componentsSeparatedByString:@"还有"]lastObject ];
        string=[[string componentsSeparatedByString:@"天"]objectAtIndex:0];
        [lastTimeArray addObject:string];
        [lastTimeArray addObject:@"天"];
    }
    NSDate*mDate=[NSDate dateWithTimeIntervalSince1970:[self.model.firstpay_end_time integerValue]];
    NSTimeInterval timeInval=[mDate timeIntervalSinceDate:date];
    NSInteger day2=(int)timeInval/86400;
    NSInteger hour=((int)timeInval-day2*86400)/3600;
    NSInteger minute=((int)timeInval-day2*86400-hour*3600)/60;
    NSInteger second=(int)timeInval-day2*86400-hour*3600-minute*60;
    NSString *Fhour=[NSString stringWithFormat:@"%02d",hour];
    NSString *Fminute=[NSString stringWithFormat:@"%02d",minute];
    NSString *Fsecond=[NSString stringWithFormat:@"%02d",second];
    [lastTimeArray addObjectsFromArray:@[Fhour,@"时",Fminute,@"分",Fsecond,@"秒"]];
    NSString *label2text=[lastTimeArray componentsJoinedByString:@""];
    _label2.text=label2text;
    
    
}

#pragma -mark mail delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:{
            
            break;
        }
        case MFMailComposeResultFailed:{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"发送Email失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];

            break;
        }
        case MFMailComposeResultSaved:{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
        case MFMailComposeResultSent:{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"已发送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];

            break;
        }
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];

}

#pragma -mark message delegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            
            break;
        case MessageComposeResultFailed:{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"您的手机无法发送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
            
        case MessageComposeResultSent:{
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"失败" message:@"成功发送此短信" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            break;
        }
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark-webview delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showInView:self.view status:@"正在加载"];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"error:%@",error.localizedDescription);
}
-(void)Toolbuttonclick{
    NSLog(@"^^^^^^^buttonclick");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
