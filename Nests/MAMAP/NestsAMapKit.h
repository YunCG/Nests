//
//  NestsAMapKit.h
//  Nests
//
//  Created by 🐠 on 12/12/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
@protocol NestsAMapKitDelegate <NSObject>
-(void)didLocationFinish:(MAPointAnnotation *)annotation
               regeocode:(AMapLocationReGeocode *)regeocode;
-(void)didLocationError:(NSError *)error;

//连续定位
-(void)didSerialLocationFinish:(AMapLocationManager *)manager annotation:(MAPointAnnotation *)annotation;
-(void)didSerialLocationError:(AMapLocationManager *)manager error:(NSError *)error;

@end
//#define  SharedNestsAMapKit  [NestsAMapKit sharedInstance]
@interface NestsAMapKit : NSObject<AMapLocationManagerDelegate>
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, assign) id<NestsAMapKitDelegate>  delegate;

#pragma mark-init
//init
//+ (id)sharedInstance;

- (void)clearLocationManager;
- (void)configLocationManager;
- (void)stopLocation;

//开启持续定位
-(void)startSerialLocation;
//带逆地理信息的一次定位
- (void)startReGeocodeLocation;
//不带逆地理信息的一次定位
- (void)startLocation;
#pragma mark-计算
//转换成高德坐标系
-(CLLocationCoordinate2D)transformAMAPCoordinate2D:(CLLocationDegrees)latitude
                                         longitude:(CLLocationDegrees)longitude
                                    coordinateType:(MACoordinateType)coordinateType;
//两点直线距离
-(CLLocationDistance)distance:(CLLocationCoordinate2D)origin
                     desPoint:(CLLocationCoordinate2D)desPoint;
//判断点是否在圆内
-(BOOL)circleContainsCoordinate:(CLLocationCoordinate2D)center
                       location:(CLLocationCoordinate2D)location
                         radius:(CGFloat)radius;
//判断点是否在可视范围
-(BOOL)rectContainsPoint:(CLLocationCoordinate2D)location
                    rect:(MAMapRect)rect;//mapview.visibleMapRect


@end
