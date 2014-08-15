//
//  MoreViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "MoreViewController.h"
#import "DeviceManager.h"
#import "HeaderView.h"
#import "MoreCell.h"
#import "MoreAnotherCell.h"
#import "LoginViewController.h"
@interface MoreViewController (){
    NSMutableArray *_dataArray;
    UISearchBar *_searchBar;
    NSInteger type;
}

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"更多";
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _dataArray = [[NSMutableArray alloc] init];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    _searchBar.placeholder = @"在完美衣橱查找朋友";
//改变searchBar的样式
    _searchBar.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar.delegate = self;
    
   
    [self.view addSubview:_searchBar];

    
    _tableView.frame = CGRectMake(0, 64+44+30, 320, [DeviceManager currentScreenHeight]-100-64-44);
    NSArray *titleArray = @[@"个人中心",@"邀请朋友",@"设置",@"应用推荐"];
    HeaderView *view =[[HeaderView alloc] initWithTitleArray:titleArray target:self frame:CGRectMake(0, 64+44, 320, 30) labelWidth:50 action:@selector(buttonClick:)];
    view.tag = 200;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 29.5, 320, 0.5)];
    label.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:label];
    [self.view addSubview:view];
    type = 1;
    UIButton *button = (UIButton *)[self.view viewWithTag:100];
    [button setBackgroundImage:[UIImage imageNamed:@"button_Seg_highlight"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"个人资料",@"私信",@"评论提醒与反馈回复",@"通知",@"意见反馈",@"清空缓存",@"私密衣橱密码锁",nil];

    if(type==1){
        [_tableView registerNib:[UINib nibWithNibName:@"MoreAnotherCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    }else{
    [_tableView registerNib:[UINib nibWithNibName:@"MoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    }
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)login
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:lvc animated:YES];
}

- (void)buttonClick:(UIButton *)button
{
    HeaderView *view = (HeaderView *)[self.view viewWithTag:200];
    for (id obj  in view.subviews) {
        if ([obj isKindOfClass:[UIButton class]] ) {
            UIButton *btn = (UIButton *)obj;
        if (btn.tag != button.tag) {
         [btn setBackgroundImage:[UIImage imageNamed:@"button_Seg_normal"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"button_Seg_highlight"] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        }
    }

    switch (button.tag) {
        case 100:
        {
            type = 1;
            if (_dataArray.count>0) {
                [_dataArray removeAllObjects];
            }
            _dataArray = [[NSMutableArray alloc] initWithObjects:@"个人资料",@"私信",@"评论提醒与反馈回复",@"通知",@"意见反馈",@"清空缓存",@"私密衣橱密码锁",nil];
            [_tableView reloadData];
            
        }
            break;
        case 101:
        {
            type = 1;
            if (_dataArray.count>0) {
                [_dataArray removeAllObjects];
            }
            _dataArray = [[NSMutableArray alloc] initWithObjects:@"手机通讯录邀请好友",@"微博邀请好友",@"微信邀请好友",nil];
            [_tableView reloadData];

        }
            break;
        case 102:
        {
            type = 1;
            if (_dataArray.count>0) {
                [_dataArray removeAllObjects];
            }
            _dataArray = [[NSMutableArray alloc] initWithObjects:@"给我们好评鼓励",@"帮助中心",@"升级到新版本",@"退出登录",@"QQ交流群",nil];
            [_tableView reloadData];

        }
            break;
        case 103:
        {
            type = 0;
            if (_dataArray.count > 0) {
                [_dataArray removeAllObjects];
            }
            [_tableView reloadData];
            
        }
            break;

        default:
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(type == 1){
    return 35.f;
    }else{
        return 90.f;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userCell = @"Cell";
    if (type == 1) {
        MoreAnotherCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
        cell.titleLabel.text = [_dataArray objectAtIndex:indexPath.row];
        return cell;
    }else if(type == 0){
        MoreCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
        return cell;
        
    }
    return nil;

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //取消第一响应者
    [_searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
    
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
