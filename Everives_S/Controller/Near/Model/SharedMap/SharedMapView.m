//
//  SharedMapView.m
//  officialDemoNavi
//
//  Created by 刘博 on 15/5/26.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "SharedMapView.h"
#import "CoreLocation/CoreLocation.h"
#import "YRMapAnnotationView.h"
#import "YRSchoolModel.h"
#import "YRCoachModel.h"
#import "YRUserStatus.h"
@interface SharedMapView ()

@property (nonatomic, readwrite) MAMapView *mapView;

@end

@implementation SharedMapView

+ (instancetype)sharedInstance
{
    static SharedMapView *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SharedMapView alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Initialized

- (instancetype)init
{
    if (self = [super init])
    {
        [self createMapView];
    }
    return self;
}



- (void)createMapView
{
    if (_mapView == nil)
    {
        _mapView = [[MAMapView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
        [_mapView setUserTrackingMode:MAUserTrackingModeNone];//定位不跟随用户移动
        //默认坐标 106.494427,29.608909
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(29.608909,106.494427);
        MACoordinateRegion region = MACoordinateRegionMake(center,MACoordinateSpanMake(.15f,.15f));
        _mapView.region = region;
        _mapView.centerCoordinate = center;
    }
}

#pragma mark - Interface

#pragma mark - MapView Dlegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
    if ([annotation isKindOfClass:[YRSchoolModel class]]
        || [annotation isKindOfClass:[YRUserStatus class]]
        ||[annotation isKindOfClass:[YRCoachModel class]]) {
        YRMapAnnotationView *annotationView = (YRMapAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[YRMapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"Neighborhood_Here"];
        
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

//更新用户地址后的回调函数
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        KUserLocation.longitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.longitude];
        KUserLocation.latitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.latitude];
        //设置地图中心
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            MACoordinateRegion region = MACoordinateRegionMake(center,MACoordinateSpanMake(.15f,.15f));
            _mapView.region = region;
            _mapView.centerCoordinate = center;
        });
        
    }
}


@end

