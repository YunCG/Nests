//
//  NestsAMapKit.m
//  Nests
//
//  Created by 🐠 on 12/12/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsAMapKit.h"
@interface NestsAMapKit ()

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@end

@implementation NestsAMapKit
@synthesize locationManager = _locationManager;

//+ (id)sharedInstance {
//    // 1
//    static NestsAMapKit* _sharedInstance = nil;
//    
//    // 2
//    static dispatch_once_t oncePredicate;
//    
//    // 3
//    dispatch_once(&oncePredicate, ^{
//        _sharedInstance = [[NestsAMapKit alloc] init];
//    });
//    return _sharedInstance;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configLocationManager];
    }
    return self;
}

- (void)dealloc
{
    [self clearLocationManager];
}

- (void)clearLocationManager
{
    [self.locationManager stopUpdatingLocation];
    
    //Restore Default Value
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setPausesLocationUpdatesAutomatically:YES];
    [self.locationManager setAllowsBackgroundLocationUpdates:NO];
    
    self.locationManager.delegate = nil;
}


#pragma mark - Action Handle

- (void)configLocationManager
{
    self.locationManager =[[AMapLocationManager alloc] init];
    self.locationManager.delegate =self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    [self initCompleteBlock];
}

//停止定位
- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation];
}


//开启持续定位
-(void)startSerialLocation
{
  [self.locationManager startUpdatingLocation];
}
//带逆地理信息的一次定位
- (void)startReGeocodeLocation
{
    
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

//不带逆地理信息的一次定位
- (void)startLocation
{
    
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}



#pragma mark - MALocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, 连续定位失败 = %@, error = %@", __func__, [manager class], error);
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didSerialLocationError:error:)]) {
        [self.delegate didSerialLocationError:manager error:error];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    NSLog(@"%s, 连续定位成功 = {lat:%f; lon:%f;}", __func__, location.coordinate.latitude, location.coordinate.longitude);
    
    if (location) {
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didSerialLocationFinish:annotation:)]) {
            
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
            [annotation setCoordinate:location.coordinate];
            [self.delegate didSerialLocationFinish:manager annotation:annotation];
        }
    }
    else
    {
        NSError* error =[[NSError alloc] initWithDomain:APP_LOCATION_ERROR_TIP code:APP_LOCATION_ERROR_CODE userInfo:nil];
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didSerialLocationError:error:)]) {
            
            [self.delegate didSerialLocationError:manager error:error];
        }
    }
//    if (location)
//    {
//        MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
//        [annotation setCoordinate:location.coordinate];
//     
//            [annotation setTitle:[NSString stringWithFormat:@"连续定位lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
//            [annotation setSubtitle:[NSString stringWithFormat:@"连续定位精度accuracy:%.2fm", location.horizontalAccuracy]];
//        
//        
//     
//        NSLog(@"连续定位当前位置11111:%@＝subTitle＝＝%@",annotation.title,annotation.subtitle);
//    }

}


- (void)initCompleteBlock
{
    __weak NestsAMapKit *wSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        
      
//        if (error)
//        {
//            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
//            
//            if (error.code == AMapLocationErrorLocateFailed)
//            {
//                return;
//            }
//        }
        NestsAMapKit *sSelf = wSelf;

        if (location)
        {
              NSLog(@"%s, 单次定位成功 = {lat:%f; lon:%f;}", __func__, location.coordinate.latitude, location.coordinate.longitude);
//            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
//            [annotation setCoordinate:location.coordinate];
//            
//            if (regeocode)
//            {
//                [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
//                [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
//            }
//            else
//            {
//                [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
//                [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
//            }
//
//          //            [sSelf addAnnotationToMapView:annotation];
//            NSLog(@"当前位置11111:%@",annotation.title);
            
            if (sSelf&&sSelf.delegate&&[sSelf.delegate respondsToSelector:@selector(didLocationFinish:regeocode:)]) {
                MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
                [annotation setCoordinate:location.coordinate];
                
                if (regeocode)
                {
                    [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
                    [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
                }
                else
                {
                    [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
                    [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
                }


                
                [sSelf.delegate didLocationFinish:annotation regeocode:regeocode];
            }

            
        }
        else
        {
              NSLog(@"%s, 单次定位失败error = %@", __func__, error);
            if (sSelf&&sSelf.delegate&&[sSelf.delegate respondsToSelector:@selector(didLocationError:)]) {
                [sSelf.delegate didLocationError:error];
            }

        }
    };
}

#pragma mark-计算
//转换成高德坐标系
-(CLLocationCoordinate2D)transformAMAPCoordinate2D:(CLLocationDegrees)latitude
                                               longitude:(CLLocationDegrees)longitude
                                          coordinateType:(MACoordinateType)coordinateType
{
  CLLocationCoordinate2D amapcoord = MACoordinateConvert(CLLocationCoordinate2DMake(latitude,longitude),coordinateType);
    return amapcoord;
}

//两点直线距离
-(CLLocationDistance)distance:(CLLocationCoordinate2D)origin
                     desPoint:(CLLocationCoordinate2D)desPoint

{
    //1.将两个经纬度点转成投影点
    MAMapPoint point1 = MAMapPointForCoordinate(origin);
    MAMapPoint point2 = MAMapPointForCoordinate(desPoint);
    //2.计算距离
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    
    return distance;
}

//判断点是否在圆内
-(BOOL)circleContainsCoordinate:(CLLocationCoordinate2D)center
              location:(CLLocationCoordinate2D)location
                         radius:(CGFloat)radius

{

    BOOL isContains = MACircleContainsCoordinate(location, center, radius);
    
    return isContains;
}
//判断点是否在可视范围
-(BOOL)rectContainsPoint:(CLLocationCoordinate2D)location
                       rect:(MAMapRect)rect//mapview.visibleMapRect


{
    //1.将annotation的经纬度点转成投影点
    MAMapPoint point = MAMapPointForCoordinate(location);
    //2.判断该点是否在地图可视范围
    BOOL isContains = MAMapRectContainsPoint(rect, point);
    return isContains;
}

@end
