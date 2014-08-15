//
//  DetailViewController.h
//  QYER
//
//  Created by Chiong on 14-6-8.
//  Copyright (c) 2014 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "outlineModel.h"
#import <MessageUI/MessageUI.h>
#import "UMSocial.h"

@interface DetailViewController : UIViewController<UIWebViewDelegate,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)outlineModel *model;
@property (nonatomic, retain)UILabel* TapToShowActionsheet;
@property(nonatomic,assign)NSInteger flag;
@property(nonatomic,copy)NSString*scroll;
@end
