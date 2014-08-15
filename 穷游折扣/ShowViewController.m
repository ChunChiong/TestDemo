//
//  ShowViewController.m
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014年 IOS. All rights reserved.
//
#define kMainUrl @"http://open.qyer.com/lastminute/get_lastminute_list?client_secret=44c86dbde623340b5e0a&client_id=qyer_discount_ios&max_id=0&product_type=%@&page_size=0&times=%@&country_id=%@&continent_id=%@&departure=%@"
#import "ShowViewController.h"
#import "MyNavigationBar.h"
#import "DeviceManager.h"
#import "ShowCell.h"
#import "AFHTTPRequestOperationManager.h"
#import "outlineModel.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "CategoryViewController.h"
#import "SVProgressHUD.h"


@interface ShowViewController ()
{
    UIScrollView*_scrollView;
    UITableView *_detailTableView;
    NSInteger _height;//手机的高度
    UILabel *_pagelabel;//放滚动视图滚动到第几页
    
    UITableView *_categoryTableView;
    NSArray *_categoryArray;
    NSArray *_categoryIDArray;
    NSString *_categoryID;
    BOOL _isCategoryTableViewOpen;
    
    UITableView *_departureTableView;
    NSArray *_departureArray;
    NSArray *_departureIDArray;
    NSString *_departureID;
    BOOL _isDepartureTableViewOpen;
    
    UITableView *_continentTableView;
    NSMutableArray *_continentArray;
    NSArray *_countryArray;
    UITableView *_countryTableView;
    BOOL _isDestinationTableViewOpen;
    NSUInteger _row;
    NSArray *_continentIDArray;
    NSString *_continentID;
    NSArray *_countryIDArray;
    NSString *_countryID;
    
    UITableView *_dateTableView;
    NSArray *_dateArray;
    NSArray *_dateIDArray;
    NSString *_dateID;
    BOOL _isDateTableViewOpen;
    
    NSMutableArray *_dataArray;
    UIImageView *_backgoundImageView;
    BOOL _isAddBackgoundImageView;
    
    SRRefreshView *_slimeView;
  
    NSMutableArray*_scrollViewModel;
}
@end

@implementation ShowViewController

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
    _scrollViewModel=[[NSMutableArray alloc]init];
    //获取当前屏幕的高度
    _height=[DeviceManager currentScreenHeight];
    self.navigationController.navigationBarHidden=YES;
    MyNavigationBar*mnb = [[MyNavigationBar alloc] init];
    mnb.frame = CGRectMake(0, 0, 320, 64);
    [mnb createMyNavigationBarWithBackgroundImageName:@"bg_titlebar.png" andTitle:Nil andTitleImageName:@"logo" andLeftBBIImageName:@[@"btn_drawer.png"] andRigtBBIImageName:nil andClass:self andSEL:@selector(bbiClick:)];
    [self.view addSubview:mnb];
    [self creatUI];
    
    _categoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 320, 300) style:UITableViewStylePlain];
    _categoryTableView.delegate = self;
    _categoryTableView.dataSource = self;
    _categoryTableView.tag = 1;
    
    _categoryArray = @[@"全部类型",@"当地游",@"机票",@"酒店",@"自由行",@"邮轮",@"租车",@"保险",@"签证",@"门票及其他"];
    _categoryIDArray = @[@"0",@"1983",@"1016",@"1017",@"1018",@"1020",@"1021",@"1049",@"1785",@"1050"];
    _isCategoryTableViewOpen = NO;
    _categoryID = @"0";
    
    _departureTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 320, 240) style:UITableViewStylePlain];
    _departureTableView.delegate = self;
    _departureTableView.dataSource = self;
    _departureTableView.tag = 2;
    
    _departureArray = @[@"全部出发地",@"北京/天津",@"上海/杭州",@"成都/重庆",@"广州/深圳",@"港澳台",@"国内其他",@"海外"];
    _departureIDArray = @[@"0",@"bjtj",@"shhz",@"cdcq",@"gzsz",@"hmt",@"inland",@"abroad"];
    _isDepartureTableViewOpen = NO;
    _departureID = @"0";
    
    _continentArray = [[NSMutableArray alloc]initWithObjects:@"全部目的地",@"热门国家",@"亚洲",@"欧洲",@"非洲",@"北美",@"南美",@"大洋洲",@"南极洲", nil];
    _isDestinationTableViewOpen = NO;
    _countryArray = @[@[@"全部目的地"],@[@"香港",@"澳门",@"台湾",@"泰国",@"马来西亚",@"法国",@"意大利",@"新加坡",@"美国",@"日本",@"德国",@"韩国",@"柬埔寨",@"英国",@"越南",@"澳大利亚",@"印度尼西亚",@"菲律宾",@"尼泊尔",@"希腊",@"新西兰",@"加拿大",@"阿联酋"],@[@"亚洲全部",@"泰国",@"新加坡",@"中国",@"韩国",@"日本",@"菲律宾",@"马来西亚",@"印度尼西亚",@"柬埔寨",@"马尔代夫",@"斯里兰卡",@"阿联酋",@"老挝",@"文莱",@"缅甸",@"伊朗",@"黎巴嫩",@"尼泊尔",@"印度",@"沙特阿拉伯",@"布丹",@"越南",@"阿曼"],@[@"欧洲全部",@"意大利",@"法国",@"瑞士",@"西班牙",@"英国",@"丹麦",@"德国",@"瑞典",@"芬兰",@"爱沙尼亚",@"俄罗斯",@"捷克",@"奥地利",@"土耳其",@"比利时",@"希腊",@"亚美尼亚",@"荷兰",@"卢森堡",@"斯洛伐克",@"波黑",@"克罗地亚",@"塞浦路斯",@"匈牙利",@"冰岛",@"爱尔兰",@"拉脱维亚",@"立陶宛",@"马其顿",@"马耳他",@"挪威",@"葡萄牙",@"罗马尼亚",@"斯洛文尼亚",@"乌克兰",@"波兰",@"梵蒂冈",@"列支敦士登"],@[@"非洲全部",@"塞舌尔",@"毛里求斯",@"埃及"],@[@"北美全部",@"美国",@"加拿大",@"巴哈马",@"格林纳达",@"牙买加",@"巴拿马",@"墨西哥"],@[@"南美全部"],@[@"大洋洲全部",@"澳大利亚",@"帕劳",@"斐济",@"北马里亚纳群岛",@"关岛",@"新西兰"],@[@"南极洲全部"]];
    
    _continentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 160, 200) style:UITableViewStylePlain];
    _continentTableView.delegate = self;
    _continentTableView.dataSource = self;
    _continentTableView.tag = 3;
    
    _countryTableView = [[UITableView alloc]initWithFrame:CGRectMake(160, 94, 160, 200) style:UITableViewStylePlain];
    _countryTableView.delegate = self;
    _countryTableView.dataSource = self;
    _countryTableView.tag = 4;
    _countryTableView.backgroundColor = [UIColor lightGrayColor];
    
    _continentID = @"0";
    _continentIDArray = @[@"0",@"-1",@"10",@"12",@"76",@"12",@"235",@"239",@"759"];
    
    _countryID = @"0";
    _countryIDArray = @[@[@"0"],@[@"1966",@"1967",@"1968",@"215",@"213",@"186",@"189",@"232",@"236",@"14",@"15",@"233",@"219",@"13",@"21",@"240",@"570",@"446",@"220",@"246",@"241",@"238",@"402"],@[@"0",@"215",@"232",@"11",@"233",@"14",@"446",@"213",@"570",@"219",@"497",@"537",@"402",@"487",@"558",@"511",@"568",@"488",@"220",@"231",@"532",@"433",@"216",@"403"],@[@"0",@"189",@"186",@"524",@"182",@"13",@"205",@"15",@"202",@"448",@"407",@"208",@"193",@"198",@"195",@"424",@"206",@"566",@"200",@"493",@"538",@"428",@"482",@"530",@"207",@"425",@"406",@"485",@"489",@"501",@"498",@"521",@"523",@"495",@"539",@"560",@"427",@"804",@"762"],@[@"0",@"531",@"503",@"244"],@[@"0",@"236",@"238",@"413",@"455",@"565",@"417",@"515"],@[@"0"],@[@"0",@"240",@"522",@"447",@"422",@"1072",@"241"],@[@"0"]];

    _dateTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 320, 260) style:UITableViewStylePlain];
    _dateTableView.delegate = self;
    _dateTableView.dataSource = self;
    _dateTableView.tag = 5;
    _dateArray = @[@"全部时间",@"1个月内",@"6个月以后",@"1-3个月",@"3-6个月",@"劳动",@"端午",@"中秋",@"国庆",@"清明",@"新年",@"春节"];
    _dateIDArray = @[@"",@"1",@"4",@"2",@"3",@"MidAutumn",@"National",@"Worker",@"DuanWu",@"QingMing",@"NewYear",@"SpringFestival"];
    _isDateTableViewOpen = NO;
    _dateID = @"";
    
    [self requestJSON];
    [self createRefreshView];
    NSLog(@"dbPath:%@",NSHomeDirectory());
}

#pragma mark-搭建UI
-(void)creatUI{
    [self createFourButton];
    [self createTableview];
    [self creatScrollView];
   
}

-(void)createFourButton{
    NSArray*array=[NSArray arrayWithObjects:@"折扣类型",@"出发地",@"目的地",@"旅行时间", nil];
    for (int i=0; i<4; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(i*80, 64, 80, 30);
        
        [button setBackgroundImage:[UIImage imageNamed:@"list_tab_left"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"list_tab_left_selected"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag=100+i;
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(fourbuttonclick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:70/255.0 green:157/255.0 blue:120/255.0 alpha:1.0] forState:UIControlStateSelected];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
}

-(void)createTableview{
    _detailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 94, 320, _height-94) style:UITableViewStylePlain];
    _detailTableView.backgroundColor = [UIColor lightGrayColor];
    _detailTableView.delegate=self;
    _detailTableView.dataSource=self;
    _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _detailTableView.tag = 0;
    [self.view addSubview:_detailTableView];
}

-(void)creatScrollView{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 94, 320, 80)];
    //_scrollView.backgroundColor=[UIColor yellowColor];
    _scrollView.contentSize=CGSizeMake(320*6, 0);
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    _scrollView.bounces = NO;
    CGPoint newOffset = _scrollView.contentOffset;
    newOffset.y = 0;
    [_scrollView setContentOffset:newOffset animated:YES];
    _detailTableView.tableHeaderView=_scrollView;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(270, 10, 35, 20)];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.3;
    [_detailTableView addSubview:label];
    _pagelabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 10, 35, 20)];
    _pagelabel.text = @"1/4";
    _pagelabel.textAlignment = NSTextAlignmentCenter;
    _scrollView.contentOffset = CGPointMake(320, _scrollView.contentOffset.y);
    _pagelabel.textColor = [UIColor whiteColor];
    _pagelabel.font = [UIFont systemFontOfSize:12];
    [_detailTableView addSubview:_pagelabel];
    
//    UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, 320, 20)];
//    backgroundLabel.backgroundColor = [UIColor blackColor];
//    backgroundLabel.alpha = 0.8;
//    [_detailTableView addSubview:backgroundLabel];
    
    [self requestScrollViewJSON];
}

- (void)createRefreshView{
    _slimeView = [[SRRefreshView alloc] init];
    _slimeView.delegate = self;
    _slimeView.upInset = 0;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [UIColor  colorWithRed:80/255.0 green:167/255.0 blue:100/255.0 alpha:1.0];
    _slimeView.slime.skinColor = [UIColor whiteColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 4;
    _slimeView.slime.shadowColor = [UIColor blackColor];
    [_detailTableView addSubview:_slimeView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_slimeView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}


- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [self requestJSON];
    [_slimeView performSelector:@selector(endRefresh)
                     withObject:nil afterDelay:3
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}





- (void)requestScrollViewJSON{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSLog(@"requestScrollViewJSON:%@",kScrollViewURL);
    [_scrollViewModel removeLastObject];
    [manager GET:kScrollViewURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if (dict) {
            NSArray *dataArray = [dict objectForKey:@"data"];
            static  NSInteger i = 0;
            for (NSDictionary *subDict in dataArray) {
            
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 0, 320, 80);
                button.backgroundColor = [UIColor clearColor];
                button.tag = 1000+i;
                //button.alpha = 0;
                NSString*title=[subDict objectForKey:@"title"];
                NSArray*titleArray=[title componentsSeparatedByString:@"|"];
               NSString* scrollviewTitle=[titleArray objectAtIndex:1];
               NSString* scrollViewPrice=[titleArray objectAtIndex:0];
               NSString* scrollViewID=[subDict objectForKey:@"ids"];
                outlineModel *model=[[outlineModel alloc]init];
                model.outlineID=scrollViewID;
                model.price=scrollViewPrice;
                model.title=scrollviewTitle;
                [_scrollViewModel addObject:model];
                [button addTarget:self action:@selector(scrollButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320*(i+1), 0, 320, 80)];
                imageView.tag=i+10000;
                //imageView.image.a
                //NSLog(@"%d",imageView.tag);
                imageView.userInteractionEnabled = YES;
                [imageView setImageWithURL:[NSURL URLWithString:[subDict objectForKey:@"big_pic"]] placeholderImage:[UIImage imageNamed:@"place_holder_large"]];
                [imageView addSubview:button];
                
                UILabel *scrollViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 300, 20)];
                scrollViewLabel.text = [subDict objectForKey:@"title"];
                scrollViewLabel.textColor = [UIColor whiteColor];
                scrollViewLabel.font = [UIFont systemFontOfSize:12.0];
                
                scrollViewLabel.layer.masksToBounds = NO;
                scrollViewLabel.layer.shadowOffset = CGSizeMake(-5,10);
                scrollViewLabel.layer.shadowOpacity = 0.3;
                scrollViewLabel.layer.shadowPath = [UIBezierPath bezierPathWithRect:scrollViewLabel.bounds].CGPath;
                [imageView addSubview:scrollViewLabel];
                
                [_scrollView addSubview:imageView];
                
                if (i==0) {
                    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(320*5, 0, 320, 80)];
                    imageView1.tag=10005;
                    imageView1.userInteractionEnabled = YES;
                    [imageView1 setImageWithURL:[NSURL URLWithString:[subDict objectForKey:@"big_pic"]] placeholderImage:[UIImage imageNamed:@""]];
                    [_scrollView addSubview:imageView1];
                }
                if (i==3) {
                    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
                    imageView2.tag=10005;
                    imageView2.userInteractionEnabled = YES;
                    [imageView2 setImageWithURL:[NSURL URLWithString:[subDict objectForKey:@"big_pic"]] placeholderImage:[UIImage imageNamed:@""]];
                    NSLog(@"picURL:%@",[subDict objectForKey:@"big_pic"]);
                    
                    [_scrollView addSubview:imageView2];
                }
                i++;
            }
            i=0;
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
}

- (void)scrollButtonClick:(UIButton *)button{
 
    outlineModel*model=[_scrollViewModel objectAtIndex:button.tag-1000];
  
    DetailViewController*div=[[DetailViewController alloc]init];
    div.model=model;
    div.scroll=@"yes";
    
    [self.navigationController pushViewController:div animated:YES];
    
}

#pragma mark-导航栏的按钮
-(void)bbiClick:(UIButton *)button{
    CategoryViewController *left = [[CategoryViewController alloc] init];
    [self.revealSideViewController pushViewController:left onDirection:PPRevealSideDirectionLeft animated:YES];
}

#pragma mark-导航栏底下四个按钮的
-(void)fourbuttonclick:(UIButton *)button{
    static NSInteger index = 0;
    
    for (int i=100; i<104; i++) {
        UIButton *but=(UIButton *)[self.view viewWithTag:i];
        but.selected=NO;
    }
    button.selected=YES;
    if (button.tag==index) {
        button.selected = NO;
        index=0;
    }else{
        button.selected = YES;
        index = button.tag;
    }

    if (button.tag==100) {
        if (_isCategoryTableViewOpen==NO) {
            [self.view addSubview:_categoryTableView];
            _isCategoryTableViewOpen=YES;
        }else{
            [_categoryTableView removeFromSuperview];
            _isCategoryTableViewOpen=NO;
            
        }
        
    }else if (button.tag==101){
        if (_isDepartureTableViewOpen==NO) {
            [self.view addSubview:_departureTableView];
            _isDepartureTableViewOpen=YES;
        }else{
            [_departureTableView removeFromSuperview];
            _isDepartureTableViewOpen=NO;
        }

    }else if (button.tag==102){
        if (_isDestinationTableViewOpen==NO) {
            [self.view addSubview:_continentTableView];
            _isDestinationTableViewOpen=YES;
        }else{
            [_continentTableView removeFromSuperview];
            [_countryTableView removeFromSuperview];
            _isDestinationTableViewOpen=NO;
        }
    }else if (button.tag==103){
        if (_isDateTableViewOpen==NO) {
            [self.view addSubview:_dateTableView];
        }else{
            [_dateTableView removeFromSuperview];
            _isDateTableViewOpen = NO;
        }
    }

}

#pragma -mark JSON解析
- (void)requestJSON{
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    aiv.center = CGPointMake(160, _height/2);
    [self.view addSubview:aiv];
    [aiv startAnimating];
    
    if (_isAddBackgoundImageView == YES) {
        [_backgoundImageView removeFromSuperview];
        _isAddBackgoundImageView = NO;
    }
    
    _dataArray = [[NSMutableArray alloc]init];
    AFHTTPRequestOperationManager  *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *downloadURLString = [NSString stringWithFormat:kMainUrl,_categoryID,_dateID,_countryID,_continentID,_departureID];
    NSLog(@"downloadURL is :%@",downloadURLString);
    [manager GET:downloadURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSArray *dataArray = [dict objectForKey:@"data"];
        if (dataArray.count) {
            for (NSDictionary *subDict in dataArray) {
                outlineModel *model = [[outlineModel alloc]init];
                model.title = [subDict objectForKey:@"title"];
                model.pic = [subDict objectForKey:@"pic"];
                model.end_date = [subDict objectForKey:@"end_date"];
               
                NSString*st = [subDict objectForKey:@"price"];
                NSArray *array=[st componentsSeparatedByString:@"<em>"];
                NSString *str=[array componentsJoinedByString:@""];
                NSArray*array1=[str componentsSeparatedByString:@"</em>"];
                NSString *str1=[array1 componentsJoinedByString:@""];
                model.price=str1;
                
                model.outlineID = [subDict objectForKey:@"id"];
                model.url = [subDict objectForKey:@"url"];
                model.detail = [subDict objectForKey:@"detail"];
                model.firstpay_end_time = [subDict objectForKey:@"firstpay_end_time"];
                model.lastminute_des = [subDict objectForKey:@"lastminute_des"];
                model.self_use = [[subDict objectForKey:@"self_use"]stringValue];
                [_dataArray addObject:model];
                [_detailTableView reloadData];
            }
            
        }else{
            [self createBackgroundImage];
            _isAddBackgoundImageView = YES;
        }
        [aiv stopAnimating];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
    
}


-(void)createBackgroundImage{
    _backgoundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 94, 320, _height-94)];
    _backgoundImageView.backgroundColor=[UIColor whiteColor];
    _backgoundImageView.userInteractionEnabled=YES;
    [self.view addSubview:_backgoundImageView];
    UILabel *imageviewcolour=[[UILabel alloc]initWithFrame:_backgoundImageView.frame];
    imageviewcolour.backgroundColor=[UIColor lightGrayColor];
    imageviewcolour.alpha=0.5;
    [_backgoundImageView addSubview:imageviewcolour];
    UIImageView * imageview1=[[UIImageView alloc]initWithFrame:
                              CGRectMake(130, 150-94, 60, 60)];
    imageview1.image=[UIImage imageNamed:@"lastminute_default_logo"];
    [_backgoundImageView addSubview:imageview1];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 230-94, 220, 30)];
    label.font=[UIFont systemFontOfSize:20];
    label.textColor=[UIColor grayColor];
    label.text=@"没有找到你想要的折扣";
    label.textAlignment=NSTextAlignmentCenter;
    [_backgoundImageView addSubview:label];
    
    UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(30,( _height-94)*2/3-60, 260, 40)];
    label1.textAlignment=NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:12];
    label1.textColor=[UIColor blackColor];
    label1.numberOfLines=0;
    label1.lineBreakMode=NSLineBreakByCharWrapping;
    label1.text=@"你可以设置一个提醒,当出现符合你设置条件的折扣时，我们会第一时间通知你！";
    [_backgoundImageView addSubview:label1];
    UIImage*image=[UIImage imageNamed:@"lastminute_remindBtn"];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake((320-image.size.width)/2, (_height-94)*2/3, image.size.width, image.size.height);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backgroundImage) forControlEvents:UIControlEventTouchUpInside];
    [_backgoundImageView addSubview:button];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        _categoryID =  _categoryIDArray[indexPath.row];
        UIButton *button = (UIButton *)[self.view viewWithTag:100];
        [button setTitle:[_categoryArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }else if (tableView.tag==2){
        _departureID = _departureIDArray[indexPath.row];
        UIButton *button = (UIButton *)[self.view viewWithTag:101];
        [button setTitle:[_departureArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }else if(tableView.tag==3) {
        _row = [indexPath row];
        UITableView *tableView2 = (UITableView *)[self.view viewWithTag:4];
        [tableView2 reloadData];
    }else if (tableView.tag == 5){
        _dateID = _dateIDArray[indexPath.row];
        UIButton *button = (UIButton *)[self.view viewWithTag:103];
        [button setTitle:[_dateArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==1) {
        [_categoryTableView removeFromSuperview];
        _isCategoryTableViewOpen = NO;
        [self requestJSON];
    }else if (tableView.tag==2){
        [_departureTableView removeFromSuperview];
        _isDepartureTableViewOpen = NO;
        [self requestJSON];
    }else if (tableView.tag==3) {
        _continentID = [_continentIDArray objectAtIndex:indexPath.row];
        [self.view addSubview:_countryTableView];
        UITableView *tableView2 = (UITableView *)[self.view viewWithTag:4];
        [tableView2 reloadData];
    }else if(tableView.tag==4){
        UIButton *button = (UIButton *)[self.view viewWithTag:102];
        [button setTitle:[_countryArray[_row] objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        [_continentTableView removeFromSuperview];
        [_countryTableView removeFromSuperview];
        _isDestinationTableViewOpen=NO;
        _countryID = [_countryIDArray[_row] objectAtIndex:indexPath.row];
            [self requestJSON];
    }else if (tableView.tag==5){
        [_dateTableView removeFromSuperview];
        _isDateTableViewOpen = NO;
        [self requestJSON];
    }    
    for (int i = 0; i<4; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:100+i];
        button.selected = NO;
    }
}

#pragma mark-tableview的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==1) {
        return _categoryArray.count;
    }else if (tableView.tag == 2){
        return _departureArray.count;
    }else if(tableView.tag == 3) {
        return _continentArray.count;
    }else if(tableView.tag == 4){
        return [_countryArray[_row] count];
    }else if (tableView.tag==5){
        return [_dateArray count];
    }else if(tableView.tag==0){
        if (_dataArray.count%2==0) {
            return _dataArray.count/2;
        }else{
            return _dataArray.count/2 +1;
        }
    }else{
        return 0;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==0) {
        static NSString *cellname=@"Cell";
        ShowCell *cell=[tableView dequeueReusableCellWithIdentifier:cellname ];
        if (cell==Nil) {
            cell=[[[NSBundle mainBundle]loadNibNamed:@"ShowCell" owner:self options:Nil]lastObject];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_dataArray.count==0) {
            return cell;
        }
        if (indexPath.row*2<=_dataArray.count-1) {
            outlineModel *model = [_dataArray objectAtIndex:indexPath.row*2];
            cell.lModel = model;
        
            cell.LtitleLabel.text = model.title;
            cell.LtimeLabel.text = model.end_date;
            cell.LpriceLabel.text = model.price;
            [cell.LimageView setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"place_holder_large"]];
            if (![model.lastminute_des isEqualToString:@""]) {
                cell.Llastminute_desLabel.text = model.lastminute_des;
            }
            if ([model.self_use isEqualToString:@"1"]) {
                cell.LSelfUseImageView.image = [UIImage imageNamed:@"icon_only"];
            }
        }
        if (indexPath.row*2+1<=_dataArray.count-1) {
            outlineModel *model = [_dataArray objectAtIndex:indexPath.row*2+1];
            cell.rModel = model;
            cell.RtitleLabel.text = model.title;
            cell.RtimeLabel.text = model.end_date;
            cell.RpriceLabel.text = model.price;
            [cell.RimageView setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"place_holder_large"]];
            if (![model.lastminute_des isEqualToString:@""]) {
                cell.Rlastminute_desLabel.text = model.lastminute_des;
            }
            if ([model.self_use isEqualToString:@"1"]) {
                cell.RSelfUseImageView.image = [UIImage imageNamed:@"icon_only"];
            }

        }
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
    else if(tableView.tag==1){
        static NSString *cellName = @"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName ];
        if (cell==Nil) {
            cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = [_categoryArray objectAtIndex:indexPath.row];
        return cell;
    }else if(tableView.tag==2){
        static NSString *cellName = @"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName ];
        if (cell==Nil) {
            cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = [_departureArray objectAtIndex:indexPath.row];
        return cell;
    }else if(tableView.tag==3) {
        static NSString *cellName = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellName];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.textLabel.text = [_continentArray objectAtIndex:indexPath.row];
        if (cell.selected==YES) {
            cell.backgroundColor = [UIColor lightGrayColor];
        }
        return cell;
    }else if(tableView.tag==4){
        static NSString *cellName = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cellName];
        if (cell==nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        cell.backgroundColor = [UIColor lightGrayColor];
        cell.textLabel.text = [_countryArray[_row] objectAtIndex:indexPath.row];
        if (cell.selected==YES) {
            cell.backgroundColor = [UIColor darkGrayColor];
        }
        return cell;
    }else{
        static NSString *cellName = @"Cell";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName ];
        if (cell==Nil) {
            cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        }
        
        cell.textLabel.text = [_dateArray objectAtIndex:indexPath.row];
        
        return cell;

    }
}

#pragma -mark ShowCell delegate
- (void)pushID:(outlineModel *)model{
    DetailViewController *dvc = [[DetailViewController alloc]init];
    dvc.model = model;
    dvc.flag = 0;
    [self.navigationController pushViewController:dvc animated:YES];
}

#pragma -mark scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   if (scrollView==_scrollView) {
        CGPoint point = scrollView.contentOffset;
        if (point.x==0) {
            scrollView.contentOffset = CGPointMake(320*4, point.y);
        }else if (point.x==320*5){
            scrollView.contentOffset = CGPointMake(320, point.y);
        }
        _pagelabel.text = [NSString stringWithFormat:@"%d/4",(int)scrollView.contentOffset.x/320];
   }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //上边的小tableView
    if (tableView.tag==1||tableView.tag==2||tableView.tag==3||tableView.tag==4||tableView.tag==5) {
        return 30.0f;
    }
    //整个页面的tableView
    return 200.f;
}
#pragma -mark 摇一摇
- (BOOL)canBecomeFirstResponder
{
    return YES;// default is NO
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"开始摇动手机");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"stop");
    NSArray*array=[NSArray arrayWithObjects:@"折扣类型",@"出发地",@"目的地",@"旅行时间", nil];
    for (int i=0; i<4; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:100+i];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [_categoryTableView removeFromSuperview];
    _categoryID = @"0";
    _isCategoryTableViewOpen = NO;
    [_departureTableView removeFromSuperview];
    _departureID = @"0";
    _isDepartureTableViewOpen = NO;
    [_continentTableView removeFromSuperview];
    [_countryTableView removeFromSuperview];
    _isDestinationTableViewOpen = NO;
    _row = 0;
    _continentID = @"0";
    _countryID = @"0";
    [_dateTableView removeFromSuperview];
    _dateID = @"";
    _isDateTableViewOpen = NO;
    [self requestJSON];
    
    UIAlertView *shakeAlert = [[UIAlertView alloc]initWithTitle:@"温馨提示：" message:@"检索功能已重置" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil,nil];
    [shakeAlert show];
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"取消");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
