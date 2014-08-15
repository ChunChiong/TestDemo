//
//  GuanzhuViewController.h
//  完美衣橱
//
//  Created by  Chiong on 14-7-7.
//  Copyright (c) 2014年  Chiong. All rights reserved.
//

#import "RootViewController.h"
#import "HttpRequest.h"
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface GuanzhuViewController : RootViewController<HttpRequestDelegate,EGORefreshTableDelegate>{
    EGORefreshTableHeaderView *_headerView;
    EGORefreshTableFooterView *_footerView;
    BOOL _isLoding;
}

@end
