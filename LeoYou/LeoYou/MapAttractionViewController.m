//
//  MapAttractionViewController.m
//  LeoYou
//
//  Created by Chiong on 14-7-13.
//  Copyright (c) 2014年 Leo. All rights reserved.
//

#import "MapAttractionViewController.h"
#import "TripNodeModel.h"
#import "MapPin.h"

@interface MapAttractionViewController () <MKMapViewDelegate> {
    MKMapView *_mapView;
    MKPolylineView *_lineView;//线的图层
    MKPolyline *_polyline;
    NSMutableArray *_pinArray;
}

@end

@implementation MapAttractionViewController

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
    _pinArray = [[NSMutableArray alloc] init];
    [self hideCusTabBar];
    [self customBackBtn];
    [self createMapView];
    [self createBottomView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.title.length > 0) {
        [self setCustomTitle:self.title];
    } else {
        [self setCustomTitle:@"地图"];
    }
}


- (void)createMapView
{
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    int nodeNum = 0;//记录真正有坐标的node
    CGFloat totalLat = 0.f;
    CGFloat totalLng = 0.f;
    int i = 0;
    for (NSArray *dayArray in _nodesArray) {
        int j;
        for (TripNodeModel *node in dayArray) {
            //NSLog(@"%@ %@ %f %f", node.entry_name, node.entry_type, node.lat, node.lng);
            if (node.lat > 0 || node.lng > 0) {
                totalLat += node.lat;
                totalLng += node.lng;
                nodeNum ++;
                CLLocationCoordinate2D lc2d = CLLocationCoordinate2DMake(node.lat, node.lng);
                MapPin *pin = [[MapPin alloc] initWithTitle:node.entry_name subTitle:nil lc2d:lc2d];
                pin.tag = (i+1)*10000+j;
                [_mapView addAnnotation:pin];
                [_pinArray addObject:pin];
                [self drawLine];
            }
            j++;
        }
        i++;
    }
    
    CLLocationCoordinate2D lc2d = CLLocationCoordinate2DMake(totalLat/nodeNum, totalLng/nodeNum);
    MKCoordinateSpan span = MKCoordinateSpanMake(15, 15);
    MKCoordinateRegion region = MKCoordinateRegionMake(lc2d, span);
    [_mapView setRegion:region];
    
}

#pragma mark MKMap delegate
//自定义大头针的样式
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *pinID = @"pin";
    MKAnnotationView *result = nil;
    if ([annotation isKindOfClass:[annotation class]] == NO) {
        return result;
    }
    
    if ([mapView isEqual:_mapView] == NO) {
        return result;
    }
    
    MapPin *myPin = (MapPin *)annotation;
    MKPinAnnotationView *anoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
    if (anoView == nil) {
        anoView = [[MKPinAnnotationView alloc] initWithAnnotation:myPin reuseIdentifier:pinID];
        anoView.canShowCallout = YES;
    }
    anoView.image = [UIImage imageNamed:@"MapPinRedSight"];
    
    result = anoView;
    return result;
}

//为地图添加图层，其实就是画线
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    return _lineView;
}

//画线
- (void)drawLine {
    [_mapView removeOverlay:_polyline];
    NSInteger num = [_pinArray count];
    CLLocationCoordinate2D coordinates[num];
    int i = 0;
    for (MapPin *currentPin in _pinArray) {
        coordinates[i] = currentPin.coordinate;
        i++;
    }
    
    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:num];
    [_mapView addOverlay:polyline];
    _polyline = polyline;
    
    _lineView = [[MKPolylineView alloc] initWithPolyline:_polyline];
    _lineView.strokeColor = [UIColor redColor];
    _lineView.lineWidth = 5;
}



- (void)createBottomView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, [DeviceManager screenHeight] - 140, 320, 80)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, 320, 70)];
    NSInteger btnNum = 0;
    for (int i=0; i<[_nodesArray count]; i++) {
        NSArray *dayArray = [_nodesArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.alpha = 1;
        [button setBackgroundColor:[UIColor whiteColor]];
        button.frame = CGRectMake((10+60)*btnNum, 0, 60, 60);
        [button setTitle:[NSString stringWithFormat:@"DAY%d", i+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        button.tag = i*100;
        [button addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:button];
        btnNum++;
        
        for (int j = 0; j<[dayArray count]; j++) {
            TripNodeModel *node = [dayArray objectAtIndex:j];
            UIButton *nodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            nodeBtn.alpha = 1;
            [nodeBtn setBackgroundColor:[UIColor whiteColor]];
            nodeBtn.frame = CGRectMake((10+60)*btnNum, 0, 60, 60);
            [nodeBtn setTitle:node.entry_name forState:UIControlStateNormal];
            [nodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [nodeBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
            nodeBtn.titleLabel.numberOfLines = 0;
            nodeBtn.tag = i*100 + j + 1;
            [nodeBtn addTarget:self action:@selector(bottomBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            [scrollView addSubview:nodeBtn];
            btnNum++;
        }
    }
    scrollView.contentSize = CGSizeMake((10+60)*btnNum, 60);
    
    [view addSubview:scrollView];
    [_mapView addSubview:view];
}

- (void)bottomBtnClicked:(UIButton *)button
{
    NSInteger section = button.tag/100;
    NSInteger row = button.tag - (button.tag/100)*100 - 1;
    //处理下第一个day的button
    row = row > 0 ? row : 0;
    NSArray *sectionArray = [_nodesArray objectAtIndex:section];
    if ([sectionArray count] > 0) {
        TripNodeModel *node = [[_nodesArray objectAtIndex:section] objectAtIndex:row];
        [self moveMapToLat:node.lat Lng:node.lng];
    }
}

- (void)moveMapToLat:(CGFloat)lat Lng:(CGFloat)lng
{
    CLLocationCoordinate2D lc2d = CLLocationCoordinate2DMake(lat, lng);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(lc2d, span);
    [UIView animateWithDuration:1 animations:^{
        [_mapView setRegion:region];
    }];
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
