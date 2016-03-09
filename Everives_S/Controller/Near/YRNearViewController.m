//
//  YRNearViewController.m
//  Everives_S
//
//  Created by darkclouds on 16/3/7.
//  Copyright © 2016年 darkclouds. All rights reserved.
//

#import "YRNearViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface YRNearViewController ()<MAMapViewDelegate>{
    MAMapView *_mapView;
}
@end

@implementation YRNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;//开启定位
    [_mapView setUserTrackingMode:MAUserTrackingModeNone];//定位不跟随用户移动
    
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        //设置地图中心
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            MACoordinateRegion region = MACoordinateRegionMake(center,MACoordinateSpanMake(.25f,.25f));
            _mapView.region = region;
            _mapView.centerCoordinate = center;
        });
    }
}

@end
