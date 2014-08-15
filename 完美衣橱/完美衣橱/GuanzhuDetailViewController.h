//
//  GuanzhuDetailViewController.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-11.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "RootViewController.h"
#import "UMSocial.h"

@interface GuanzhuDetailViewController : RootViewController<UMSocialUIDelegate>

@property (nonatomic , copy) NSString *flow_Id;

@end
