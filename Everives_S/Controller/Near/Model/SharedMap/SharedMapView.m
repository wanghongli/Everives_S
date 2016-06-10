//
//  SharedMapView.m
//  officialDemoNavi
//
//  Created by 刘博 on 15/5/26.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import "SharedMapView.h"
#import "CoreLocation/CoreLocation.h"
#import "YRSchoolModel.h"
#import "YRCoachModel.h"
#import "YRUserStatus.h"
#import "YRSchoolAnnotationCalloutView.h"

@interface SharedMapView ()<UIAlertViewDelegate>
{
     AMapSearchAPI *_search;
}

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
        //初始化检索对象
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
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
        _mapView.rotateEnabled = NO;
        _mapView.showsCompass= NO;
        _mapView.showsScale = NO;
        _mapView.distanceFilter = 10.0;
    }
}


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
            
            annotationView.image = [UIImage imageNamed:@"Neighborhood_Here"];
            
            // 设置为NO，用以调用自定义的calloutView
            annotationView.canShowCallout = NO;
            
            // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
            annotationView.centerOffset = CGPointMake(0, -18);
            annotationView.delegate = self.delegate;
           
        }
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
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
//        取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
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
        
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 10000;
        regeo.requireExtension = YES;
        
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeo];
        
    }
}

-(void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSString *errorString;
//    NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
        {
            //Access denied by user
            errorString = @"请打“开定位服”务来允许Everives确定您的位置";
            //Do something...
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"取消", nil];
            [alert show];
            break;
        }
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"定位信息不可用";
            //Do something else...
            break;
        default:
            errorString = @"位置错误";
            break;
    }

    
}
#pragma mark - AMapSearchDelegate
//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *formattedAddress = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.formattedAddress];
        KUserLocation.addr = formattedAddress;
        //同步地理位置信息

        [RequestData PUT:USER_ADDRESS parameters:@{@"lat":KUserLocation.latitude,@"lng":KUserLocation.longitude,@"address":KUserLocation.addr} complete:^(NSDictionary *responseDic) {

        } failed:^(NSError *error) {
            
        }];
    }
}

#pragma mark - private methods
//在弹出的view中，提示打开设置
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self openSettings];
    }
}
- (void)openSettings
{
    BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
    if (canOpenSettings) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}
@end

