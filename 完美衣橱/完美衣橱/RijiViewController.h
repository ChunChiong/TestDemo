//
//  RijiViewController.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-17.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "ParentsViewController.h"

@interface RijiViewController : ParentsViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSCalendar *myCalendar;
    NSRange monthRange;
    int currentDayIndexOfMonth;
    int firstDayIndexOfWeek;
}
- (IBAction)yearAddClick:(UIButton *)sender;
- (IBAction)yearReduceClick:(UIButton *)sender;
- (IBAction)monthAdd:(UIButton *)sender;
- (IBAction)monthReduce:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property(nonatomic,retain)UIView* grayBG;



@end
