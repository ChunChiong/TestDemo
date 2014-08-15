//
//  MobanLiebiaoViewController.m
//  完美衣橱
//
//  Created by  Chiong on 14-7-17.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "MobanLiebiaoViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MobanModel.h"
#import "MobanCell.h"
#import "UIImageView+WebCache.h"

@interface MobanLiebiaoViewController (){
    NSMutableArray *_dataArray;
}

#define kMObanliebiaoUrlString @"http://open.wanmeiyichu.com/api//style.template?uid=254512&key=e9ca2033904e333acfb1e3bd74d7ca09&pagesize=30&page=1"

@end

@implementation MobanLiebiaoViewController

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
    
    _dataArray = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"模板列表";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"frame_title_btn_left_long_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    [manager GET:kMObanliebiaoUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSArray *array = [dict objectForKey:@"reqdata"];
        for (int i = 0; i<array.count; i++) {
            MobanModel *model = [[MobanModel alloc] init];
            NSArray *imgArray = [array[i] objectForKey:@"data_img"];
            NSString *img = [imgArray[0] objectForKey:@"img"];
            model.Imageview = img;
            model.tagArray = [array[i] objectForKey:@"tag"];
            model.content = [array[i] objectForKey:@"description"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MobanCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *userCell = @"Cell";
    MobanCell *cell = [tableView dequeueReusableCellWithIdentifier:userCell forIndexPath:indexPath];
    
    MobanModel *model = [_dataArray objectAtIndex:indexPath.row];
    [cell.imageview setImageWithURL:[NSURL URLWithString:model.Imageview]];
    NSArray *Array = model.tagArray;
    NSString *str1 = [[NSString alloc]init];
    NSLog(@"ARRAY:%@",Array);
    for (int i=0; i<Array.count; i++) {
        NSString *str = [NSString stringWithFormat:@" #%@#  ",Array[i]];
        str1 = [str1 stringByAppendingFormat:@"%@", str];
    }

    cell.tagLabel.text = str1;
    cell.contentLabel.text = model.content;
    
    
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
