//
//  NestsMapViewController.m
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsMapViewController.h"
#import "CornerHomeInfoData.h"
#import "CornerHomeInfoData+Operation.h"


/* 高德地图注册scheme:iosamap */
#define AMAPScheme @"iosamap://"

@interface NestsMapViewController ()<MAMapViewDelegate, AMapSearchDelegate>
{
      UIButton* navigationRightBtn;
    CGFloat  zoomNum;
}

@property(nonatomic,retain) CornerHomeInfoData* dataSource;
@property(nonatomic,retain) NSMutableArray* pointsArray;

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;


@end

@implementation NestsMapViewController
@synthesize mapView = _mapView;
@synthesize search  = _search;

- (void)dealloc
{
    [self clearMapView];
    [self clearSearch];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupDataSource];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.annotaitonArray  isKindOfClass:[NSArray class]]) {
        for (int index =0; index <[self.annotaitonArray count]; index++) {
            MAPointAnnotation* point =[self.annotaitonArray objectAtIndex:index];
            [self.pointsArray addObject:point];
        }
    }
    
    self.title = @"地图";
    [self setupNavigaionBar];
    [self setupMainView];
 
 zoomNum= 16.1;
    [self startLocationDesPoint];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
  
    
}
#pragma mark-DataSource
- (void)setupDataSource {
    self.dataSource =[[CornerHomeInfoData alloc] init];
    self.pointsArray =[[NSMutableArray alloc] init];
    
   
   
}



#pragma mark-setup

-(void)setupNavigaionBar
{
    self.navigationController.navigationBar.translucent = NO;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zone_jifen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(returnAction)];

}


//
//-(void)listBtnAction:(UIButton*)sender
//{
//    DDDLog(@"地图模式");
//
//    
//}

-(void)setupMainView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    [self setupMaMape];
    [self setupSearch];
    
    [self setupMapBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"NestsResideMenuFirstViewController will appear");
    [self  startMapLocation];
    
    if (self.isShowNearby) {
        [self netMerShopingkepperList];
    }
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"NestsMapViewController will disappear");
    [self stopMapLocation];
}

#pragma mark-返回
- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self clearMapView];
    
    [self clearSearch];
}

#pragma mark-MAMape
-(void)stopMapLocation
{
    
    self.mapView.showsUserLocation = NO;
    
}

-(void)startMapLocation
{
    if (self.isLocation) {
        self.mapView.showsUserLocation = YES;
        self.mapView.pausesLocationUpdatesAutomatically =NO;
        self.mapView.allowsBackgroundLocationUpdates =YES;
        self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
         [self.mapView setZoomLevel:16.1 animated:NO];
        
        [self.mapView setZoomEnabled:YES];
        
    }


}
-(void)setupMaMape
{
    self.mapView =[[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    
        self.mapView.delegate = self;
    
   //若想自定义定位经度圈样式，需先将 MAMapView 的customizeUserLocationAccuracyCircleRepresentation 属性设置为 YES。
//    self.mapView.customizeUserLocationAccuracyCircleRepresentation =YES;
    
    [self.view addSubview:self.mapView];
}
- (void)setupSearch
{
    self.search.delegate = self;
}
- (void)clearMapView
{
    self.mapView.showsUserLocation = NO;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlays:self.mapView.overlays];
    
    self.mapView.delegate = nil;
}

- (void)clearSearch
{
    self.search.delegate = nil;
}


#pragma mark-自定义经度圈样式
//- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
//{
//    /* 自定义定位精度对应的MACircleView. */
//    if (overlay == mapView.userLocationAccuracyCircle)
//    {
//        MACircleView *accuracyCircleView = [[MACircleView alloc] initWithCircle:overlay];
//        
//        accuracyCircleView.lineWidth    = 2.f;
//        accuracyCircleView.strokeColor  = [UIColor lightGrayColor];
//        accuracyCircleView.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
//        
//        return accuracyCircleView;
//    }
//    return nil;
//}
//
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    /* 自定义userLocation对应的annotationView. */
//    if ([annotation isKindOfClass:[MAUserLocation class]])
//    {
//        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
//        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
//        }
//        annotationView.image = [UIImage imageNamed:@"userPosition"];
//        
//        return annotationView;
//    }
//    return nil;
//}
#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}


#pragma mark-位置更新
-(void)mapView:(MAMapView *)mapView
    didUpdateUserLocation:(MAUserLocation *)userLocation
    updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"当前位置latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

#pragma mark-MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}


- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if ([view.annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MANaviConfig * config = [[MANaviConfig alloc] init];
        config.destination = view.annotation.coordinate;
        config.appScheme = [self getApplicationScheme];
        config.appName = [self getApplicationName];
        config.strategy = MADrivingStrategyShortest;
        
        if(![MAMapURLSearch openAMapNavigation:config])
        {
            [MAMapURLSearch getLatestAMapApp];
        }
    }
}


- (NSString *)getApplicationName
{
    NSDictionary *bundleInfo = [[NSBundle mainBundle] infoDictionary];
    return [bundleInfo valueForKey:@"CFBundleDisplayName"];
}

- (NSString *)getApplicationScheme
{
    NSDictionary *bundleInfo    = [[NSBundle mainBundle] infoDictionary];
    NSString *bundleIdentifier  = [[NSBundle mainBundle] bundleIdentifier];
    NSArray *URLTypes           = [bundleInfo valueForKey:@"CFBundleURLTypes"];
    
    NSString *scheme;
    for (NSDictionary *dic in URLTypes)
    {
        NSString *URLName = [dic valueForKey:@"CFBundleURLName"];
        if ([URLName isEqualToString:bundleIdentifier])
        {
            scheme = [[dic valueForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
            break;
        }
    }
    
    return scheme;
}
#pragma mark-大头钉定位
-(void)startLocationDesPoint
{
    
    if (self.desPoint) {
   
        [self.mapView addAnnotation:self.desPoint];
        [self.mapView setCenterCoordinate:self.desPoint.coordinate];
        [self.mapView setZoomLevel:15.1 animated:YES];
//      [self.mapView selectAnnotation:self.desPoint animated:NO];

    }
    
   }


#pragma mark-大头钉
-(void)hobnail
{
    if (self.pointsArray.count>0) {
        [self.mapView removeAnnotations:self.pointsArray]
        ;
        [self.mapView addAnnotations:self.pointsArray];
        
      
    }
    
    
   

}
#pragma mark-Network
-(void)netMerShopingkepperList
{

       
    int pageSize  =1;
    int pageNum  =10000;
    
    
    NSString* location =[self objectForUserDefaults:APP_USER_LOCATION];
    if ([location isKindOfClass:[NSString class]]&&(location.length>0)) {
        DDDLog(@"当前位置坐标＝＝%@",location);
        CGPoint  locationPoint =CGPointFromString(location);
        DDDLog(@"当前位置坐标 = {lat:%f; lon:%f;}", locationPoint.x, locationPoint.y);
        NSString* lat =[NSString stringWithFormat:@"%f",locationPoint.x];
        NSString* lon =[NSString stringWithFormat:@"%f",locationPoint.y];
        
        [self.networkClient  netMerShopingkepperList: NET_MER_SHOPINGKEPPER_LIST_ID type:@"0"
                                                 lat:lat
                                                 lon:lon region:@"" region2:@"" region3:@"" name:@"" pageSize:pageSize pageNum:pageNum  delegate:self
                                           didFinish:@selector(didNetMerShopingkepperListFinish:userInfo:)
                                           didFailed:@selector(didFailed:userInfo:)
                                            userInfo:nil];
        
        
    }
    
    
    
    
}

- (void)didNetMerShopingkepperListFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"信息请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoArray =resultDic[@"result"];
            if ([infoArray  isKindOfClass:[NSDictionary class]]) {
                id list =infoArray[@"list"];
                
                if ([list  isKindOfClass:[NSArray class]]) {
                    [self.dataSource.listArray  removeAllObjects];
                    self.dataSource.listArray =[[NSMutableArray alloc] initWithArray:list];
//                    [self.mainTableView reloadData];
                    
                    for (int index=0; index<[self.dataSource.listArray count]; index++) {
                        NSDictionary* infoDic =[self.dataSource.listArray objectAtIndex:index];
                        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
                            
                           
                            
                            NSString* lat =infoDic[@"lat"]?infoDic[@"lat"]:@"";
                            NSString* lon =infoDic[@"lng"]?infoDic[@"lng"]:@"";
                            NSString* title =infoDic[@"name"]?infoDic[@"name"]:@"";
                            NSString* addr =infoDic[@"addr"]?infoDic[@"addr"]:@"";
                            if ((![lat.trim isEqualToString:@""])&&(![lon.trim isEqualToString:@""]))
                            {
                                 MAPointAnnotation* point =[[MAPointAnnotation alloc] init];
                                CLLocationCoordinate2D pointCoordinate=CLLocationCoordinate2DMake(lat.floatValue,lon.floatValue);
                                [point setCoordinate:pointCoordinate];
                                
                                point.title =title;
                                point.subtitle =addr;
                                
                                [self.pointsArray addObject:point];
                                
                            }
                        }
                        
                    }
                    
                    [self hobnail];//大头钉
                    
                 

                    
                }
            }
            
            
            
            
        }
        else
        {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSString class]]) {
                
                NSString* messages =infoData;
                NSError* error =[[NSError alloc] initWithDomain:messages code:APP_SERVER_CODE userInfo:nil];
                [self didFailed:error userInfo:nil];
                
            }
            
            
        }
    }
    else
    {
        NSError* error =[[NSError alloc] initWithDomain:APP_SERVER_DEFAULT_TIP code:APP_SERVER_ERROR_SEVER_DEFAULT_CODE userInfo:nil];
        [self didFailed:error userInfo:nil];
    }
    
    
    
}
///////////////////////////////FAILED///////////////////////
//- (void)didFailed:(NSError *)error userInfo:(NSDictionary *)userInfo {
//    DDDebug(@"网络失败==%@", error);
//    [SVProgressHUD dismiss];
//    NSString* messages =APP_NETWORK_DEFAULT_ARRER;
//    switch (error.code) {
//        case APP_SERVER_ERROR_SEVER_DEFAULT_CODE:
//        {
//            messages =APP_SERVER_DEFAULT_TIP;
//        }
//            break;
//        case APP_SERVER_ERROR_SEVER_INFO_CODE:
//        {
//            messages =APP_SERVER_INFO_TIP;
//        }
//            break;
//        case APP_SERVER_ERROR_LOGIN_CODE:
//        {
//            messages =APP_USER_LOGIN_TIP;
//        }
//            break;
//        case APP_SERVER_CODE:
//        {
//            messages =error.domain;
//        }
//            break;
// 
//        default:
//        {
//            messages =APP_NETWORK_DEFAULT_ARRER;
//        }
//            break;
//    }
//    
//
//        
//        [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//        
//    
//
//    
//}
#pragma mark-定位
-(void)setupMapBtn
{
    
    CGFloat screen_width =CGRectGetWidth(self.view.frame);
    CGFloat screen_height =CGRectGetHeight(self.view.frame);
    
    
    UIButton* locationBtn =[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60, 60, 50, 50)];
    [locationBtn  setImage:[UIImage imageNamed:@"nests_location"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(locationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:locationBtn];
    
    
    
    UIButton* leaveBtn =[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60, screen_height-300, 40, 40)];
    leaveBtn.tag =0;
    [leaveBtn  setImage:[UIImage imageNamed:@"nests_max"] forState:UIControlStateNormal];
    [leaveBtn addTarget:self action:@selector(leaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leaveBtn];
    
    
    UIButton* leaveBtn1 =[[UIButton alloc] initWithFrame:CGRectMake(screen_width-60, screen_height-240, 40, 40)];
     leaveBtn1.tag =1;
    [leaveBtn1  setImage:[UIImage imageNamed:@"nests_min"] forState:UIControlStateNormal];
    [leaveBtn1 addTarget:self action:@selector(leaveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:leaveBtn1];

    
    
    
}

-(void)locationBtnAction:(UIButton*)btn
{
     [self startMapLocation];
    
//    [self.mapView setZoomLevel:10.1 animated:YES];
}

-(void)leaveBtnAction:(UIButton*)btn
{
    NSInteger tag =btn.tag;
    NSInteger offset =1;
    
    if (tag) {
        zoomNum+=offset;
    }
    else
    {
        zoomNum-=offset;
    }
    
    if (zoomNum>20.1) {
        zoomNum =20.1;
    }
//
    if (zoomNum<8) {
        zoomNum =8;
    }
//
    
    DDDLog(@"缩放比例:%f",zoomNum);
    
     [self.mapView setZoomLevel:zoomNum animated:YES];

}

@end
