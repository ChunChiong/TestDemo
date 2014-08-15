//
//  URLDEFINE.h
//  LeoYou
//
//  Created by 赵 辉 on 14-7-8.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#ifndef LeoYou_URLDEFINE_h
#define LeoYou_URLDEFINE_h

#define kURLCacheTime 60*60*6
#define kUserCache 1
#define kCachePath @"/Library/Caches/WebCache"

#define kURLfeatured @"http://chanyouji.com/api/trips/featured.json?page=%d"
#define kURLTripArticle @"http://chanyouji.com/api/trips/%d"
//专题
#define kURLSub @"http://chanyouji.com/api/articles.json?page=%d"
#define KURLArticle @"http://chanyouji.com/api/articles/%d.json?page=%d"


//目的地
#define KURLDes @"http://chanyouji.com/api/destinations.json?page=%d"
//口袋书
#define KURLBook @"http://chanyouji.com/api/destinations/%d.json?page=%d"
//行程
#define kURLTraval @"http://chanyouji.com/api/destinations/plans/%d.json?page=%d"
//行程详情
#define kURLPlansDetail @"http://chanyouji.com/api/plans/%d.json?page=1"
//旅行地
#define kURLLocation @"http://chanyouji.com/api/destinations/attractions/%d.json?per_page=20&page=%d"
//旅行地详情
#define kURLAttractionDetail @"http://chanyouji.com/api/attractions/%d.json?page=1"
//目的地专题
#define kURLDesSub @"http://chanyouji.com/api/articles.json?destination_id=%d&page=%d"

//查询游记
#define kURLSearchTrip @"http://chanyouji.com/api/search/trips.json?q=%@&page=%d"


#endif
