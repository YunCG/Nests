//
//  AppDelegate.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "AppDelegate.h"
#import "XGPush.h"
#import "XGSetting.h"
#import <MAMapKit/MAMapKit.h>
#import "NestsAMapKit.h"



@interface AppDelegate ()<NestsAMapKitDelegate>
@property(nonatomic, retain) ASIHTTPClicent *networkClient;
@property(nonatomic, retain) NestsAMapKit *nestsAMapKit;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
      self.networkClient = [[ASIHTTPClicent alloc] init];
   
    
    //Log
    [self setupLumberjack];
    //FMDB
    [self setupSQLite];
    //XGPush
    [self setupXGPush:launchOptions];
    
    //MAMAP
    [self setupMaMap];
    
    //LaunchOptions
    [self  appLaunchOption:launchOptions];
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  
  
    


      [self netDownloadFile];
    
    /********************************Test****************************************/
   
//    [SharedNestsSQLite saveRemoteMessage:@"message=111111=test" isRead:NO];
//
//     NSArray*  messagesArray = [SharedNestsSQLite  queryRemoteMessages];
//    for (NSDictionary* infoDic in messagesArray)
//    {
//   
//        
//        NSString* messages =infoDic[@"messages"];
//         NSString* isRead =infoDic[@"isRead"];
//         NSString* createdTime =infoDic[@"createdTime"];
//         NSString* messageID=infoDic[@"id"];
//        
//        DDDLog(@"messages====%@",messages);
//         DDDLog(@"isRead====%@",isRead);
//         DDDLog(@"createdTime====%@",createdTime);
//         DDDLog(@"messageID====%@",messageID);
//
//    }
     /********************************Test****************************************/
    
    
//    [self netSecurityCode];
    
    self.window.rootViewController =
    [SharedNestsSceneDispatch rootNavigationController];
  [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark-LaunchOption
-(void)appLaunchOption:(NSDictionary *)launchOptions
{
    NSURL *openURL = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    UILocalNotification * localNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if (openURL) {
        NSString *bundleId = [launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
        DDDLog(@"通过openURL:启动%@",bundleId);
    }
    else if(localNotification)
    {
        DDDLog(@"本地通知启动");
    }
    else if(remoteNotification)
    {
        DDDLog(@"远程通知启动");
//            [self performSelector:@selector(remoteNotification:) withObject:remoteNotification afterDelay:0.8];
        [self remoteNotification:remoteNotification];
        
    }
    else
    {
        DDDLog(@"用户直接启动");
    }
    

}
#pragma mark - Logs
// config lumberjack
- (void)setupLumberjack
{
    // Enable XcodeColors（插件）
    setenv("XcodeColors", "YES", 0);
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    // And then enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    DDLogError(@"Paper jam");                              // Red
    DDLogWarn(@"Toner is low");                            // Orange
    DDLogInfo(@"Warming up printer (pre-customization)");  // Default (black)
    DDLogVerbose(@"Intializing protcol x26");              // Default
    
    //将Log写入文件
    //       DDFileLogger*  fileLogger = [[DDFileLogger alloc] init];
    //       fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    //       fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    //       [DDLog addLogger:fileLogger];
}

#pragma mark-MAMAP
-(void)setupMaMap
{
    if ([MAMAP_APP_KEY length] == 0)
    {
#define kMALogTitle @"提示"
#define kMALogContent @"高德地图 apiKey为空，请检查key是否正确设置"
        
        NSString *log = [NSString stringWithFormat:@"[MAMapKit] %@", kMALogContent];
        NSLog(@"%@", log);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kMALogTitle message:kMALogContent delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        });
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)MAMAP_APP_KEY;
    [AMapLocationServices sharedServices].apiKey = (NSString *)MAMAP_APP_KEY;
    
    [self startLocation];
    
    
}

-(void)startLocation
{
    
    self.nestsAMapKit =[[NestsAMapKit alloc] init];
    self.nestsAMapKit.delegate =self;
    [ self.nestsAMapKit    startLocation];

}

-(void)didLocationFinish:(MAPointAnnotation *)annotation
               regeocode:(AMapLocationReGeocode *)regeocode
{
     DDDLog(@"单次定位成功 = {lat:%f; lon:%f;}", annotation.coordinate.latitude, annotation.coordinate.longitude);
    
    CGFloat lat =annotation.coordinate.latitude;
    CGFloat lon =annotation.coordinate.longitude;
//    NSString* title =annotation.title?annotation.title:@"";
//    NSString* subTitle =annotation.subtitle?annotation.subtitle:@"";
    NSString* location =[NSString stringWithFormat:@"{%f,%f}",lat,lon];
    [self saveUserDefaultsNotNil:location  keyValue:APP_USER_LOCATION];
    
    
    
}
-(void)didLocationError:(NSError *)error
{
   DDDLog(@"定位失败！")
    
    NSArray* titlesArray =@[@"重新定位"];
    __weak AppDelegate *wSelf = self;
    
    [UIAlertView  showWithTitle:@"提示" message:@"定位失败"  style:UIAlertViewStyleDefault cancelButtonTitle:@"取消" otherButtonTitles:titlesArray tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
     {
         NSLog(@"buttonIndex==%ld",buttonIndex);
         switch (buttonIndex) {
             case 0:
             {
                 DDDLog(@"取消");
             }
                 break;
             case 1:
             {
                 DDDLog(@"重新定位");
                 AppDelegate *sSelf = wSelf;
                 [sSelf startLocation];
             }
                 break;
                 
             default:
                 break;
         }
     }];

    
    
}

#pragma mark-XGPush
-(void)setupXGPush:(NSDictionary *)launchOptions
{
    //Push register
    [XGPush startApp:XG_ACCESS_ID appKey:XG_ACCESS_KEY];
//    //PUSH ACOUNT
//    [XGPush setAccount:@"123456"];
//    //PUSH TAG
//      NSString* tag= [NSString stringWithFormat:@"%@%@",XG_PUSH_TAG,@"NEW"];
//      [XGPush setTag: tag];
   
 
//  [XGPush unRegisterDevice];//注销设备，此台设备不接收推送。
    // 如果注销过信鸽，需要再次注册push服务前的准备（重新注册）
    [XGPush initForReregister:^(void){
        //如果变成需要注册状态
        if(![XGPush isUnRegisterStatus])
        {
            //注册成功之后
            //iOS8注册push方法
            float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
            if(sysVer < 8){
                [self registerPush];
            }
            else{
                [self registerPushForIOS8];
            }
            
        }
    }];
    
    
    //角标清0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //清除所有通知(包含本地通知)
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    //推送反馈.(app没有运行时，点击推送启动时),支持回调版本
//    [XGPush handleLaunching:launchOptions successCallback: ^(void){
//        //成功之后的处理
//        NSLog(@"[XGPush]handleLaunching's successBlock");
//        
//    } errorCallback:^(void){
//        //失败之后的处理
//        NSLog(@"[XGPush]handleLaunching's errorBlock");
//    }];
    //推送反馈
    [XGPush handleLaunching: launchOptions];

  
    

}
- (void)registerPushForIOS8{
    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    //Actions
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    
    //    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    //    acceptAction.title = @"Accept";
    
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    //Categories
    UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    inviteCategory.identifier = @"INVITE_CATEGORY";
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
    NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)registerPush{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
    //PUSH ACOUNT
    [XGPush setAccount:@"123456"];
    //PUSH TAG
    NSString* tag= [NSString stringWithFormat:@"%@%@",XG_PUSH_TAG,@"NEW"];
    [XGPush setTag: tag];
    
    //注册设备
    XGSetting *setting = (XGSetting *)[XGSetting getInstance];
    [setting setChannel:@"appstore"];
    [setting setGameServer:@"分儿客户端"];
      NSString * deviceTokenStr =[XGPush registerDevice:deviceToken];
//    NSString * deviceTokenStr = [XGPush registerDevice: deviceToken];
    

    //打印获取的deviceToken的字符串
    NSLog(@"打印获取的deviceToken的字符串 deviceTokenStr is %@",deviceTokenStr);
}

//如果deviceToken获取不到会进入此事件
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@",err];
    
    NSLog(@"[设备Token 获取不到]%@",str);
    
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo
{
    [XGPush handleReceiveNotification:userInfo];//统计
    
//      [self performSelector:@selector(remoteNotification:) withObject:userInfo afterDelay:0.8];//App在前台没提示收到消息
    
    [self remoteNotification:userInfo];
    
    //本地推送
//    NSDate *fireDate = [[NSDate new] dateByAddingTimeInterval:10];
//    
//    NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] init];
//    [dicUserInfo setValue:@"myid" forKey:@"clockID"];
//    
//    
//     UILocalNotification *notification=[[UILocalNotification alloc] init];
//    notification.timeZone=[NSTimeZone defaultTimeZone];
//    notification.fireDate=fireDate;
//     notification.repeatInterval=0;
//    notification.applicationIconBadgeNumber = 1;
//       [notification setSoundName:UILocalNotificationDefaultSoundName];
//      [notification setUserInfo:userInfo];
//       [[UIApplication sharedApplication]   scheduleLocalNotification:notification];
//    
    
//    NSDictionary *olduserInfo = dicUserInfo;
////
//    [XGPush localNotification:fireDate alertBody:@"测试本地推送" badge:2 alertAction:@"确定" userInfo:olduserInfo];
//     DDDLog(@"远程推送返回＝1111＝＝＝%@",userInfo);
  }

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
     DDDLog(@"本地推送222＝＝%@",notification);
    //notification是发送推送时传入的字典信息
    //userInfoKey:@"clockID" userInfoValue:@"myid" 用于删除推送
//    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];
    //删除推送列表中的这一条
//    [XGPush delLocalNotification:notification];
    //[XGPush delLocalNotification:@"clockID" userInfoValue:@"myid"];
    
    //清空推送列表
    [XGPush clearLocalNotifications];
}
#pragma mark-remoteNotification
-(void)remoteNotification:(NSDictionary *)userInfo;
{
    
    NSString* remoteMessages =[userInfo JSONString];
    DDDLog(@"远程推送返回＝＝＝＝%@",remoteMessages);
//     [UIAlertView  showWithTitle:@"推送提示" message:remoteMessages style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//    [self insertSqlite:pushJSON];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Push_WebView
//                                                        object:self
//                                                      userInfo:userInfo];
    
    
//      [SharedNestsSQLite saveRemoteMessage:remoteMessages isRead:NO];
    [self saveNotificationMessage:remoteMessages];
}

#pragma mark-SQLite
-(void)setupSQLite
{
    
    [SharedNestsSQLite createSQLite];
    
}


-(void)saveNotificationMessage:(NSString*)notificationMessage
{
    DDDLog(@"notificationMessage===%@",notificationMessage);
    
    [SharedNestsSQLite saveRemoteMessage:notificationMessage isRead:NO];
}
#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController: %@", NSStringFromClass([menuViewController class]));
}


#pragma mark-TEST
//-(void)netSecurityCode
//{
//  
//    [self.networkClient netSecurityCode:NET_USER_SECURITY_ID
//                              delegate:self
//                             didFinish:@selector(didSecurityCodeFinish:userInfo:)
//                             didFailed:@selector(didSecurityCodeFailed:userInfo:)
//                              userInfo:nil];
//
//
//}

- (void)didSecurityCodeFinish:(id)result userInfo:(NSDictionary *)userInfo {
  DDDebug(@"网络test查询成功==%@", result);
}
- (void)didSecurityCodeFailed:(NSError *)error userInfo:(NSDictionary *)userInfo {
  DDDebug(@"网络test查询失败==%@", error);
}






#pragma mark-Network
-(void)netDownloadFile
{
    //下载服务器DB配置文件
    NSString* destinationPath =[NestsKit sandBoxLibCachePath];
    [self.networkClient  netDownloadFile:NET_DOWND_SQLLITE_ID
                                fileName:APP_SERVER_DB
                         destinationPath:destinationPath
                                delegate:self
                               didFinish:@selector(didNetDownloadFileFinish:userInfo:)
                               didFailed:@selector(ddidNetDownloadFileFailed:userInfo:)
                                userInfo:nil];

  }

- (void)didNetDownloadFileFinish:(id)result userInfo:(NSDictionary *)userInfo {
    DDDebug(@"下载数据库查询成功==%@", result);
}
- (void)ddidNetDownloadFileFailed:(NSError *)error userInfo:(NSDictionary *)userInfo {
    DDDebug(@"下载数据库查询失败==%@", error);
}


///////////////////////////////FAILED///////////////////////

@end
