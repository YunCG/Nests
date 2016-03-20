//
//  NestsRootViewController.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsRootViewController.h"
#import "AppDelegate.h"


@interface NestsRootViewController ()
@end

@implementation NestsRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
 
 
    
    
//    NSString* strLocal =LocalString(@"teststring", @"ResourcesStrings");
//    DDDebug(@"本地化＝＝＝＝＝＝＝%@",strLocal);
//    
//    DDDebug(@"设备唯一表示＝＝＝%@",[NestsKit deviceIdentifier]);
//    
//    UILabel* title =[[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [title setText:strLocal];
////     [title  setFont:[UIFont fontWithName:@"Digital-7Mono" size:28]];
//      title.font = [UIFont fontWithName:APP_FONT_DIGITAL size:28];
////    [title showCircle:50 borderColor:[UIColor greenColor] borderWidth:1.0];
//    [self.view addSubview:title];
    
    UIView* rootView = self.navigationController.view;
    BOOL isFirstLanch = [NestsKit isAppFirstLanch];
    NSLog(@"第一次启动flag:%i",isFirstLanch);
//    if (isFirstLanch) {
//        [NestsKit saveAppFirstLanch:NO];
//        [self showIntroWithCrossDissolve:rootView];
//    }
//    else
//    {
    
//        [self setupHomeViewController];
    
//    }
    
//
    
    [self setupMainView];
    
       [self performSelector:@selector(netAppLaunch)];
    
    [self performSelector:@selector(netUserPersonInfo)];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-setupMainView
-(void)setupMainView
{

    
    [self.view  setBackgroundColor:[UIColor colorWithRed:0.99 green:0.75 blue:0.00 alpha:1.0]];
   
}
#pragma mark-Setup
-(void)setupHomeViewController
{
    

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = appDelegate.window;
    UIViewController* homeVC =[SharedNestsSceneDispatch nestsRESideMenuViewController:self];
    mainWindow.rootViewController =homeVC;

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


#pragma mark-IntroDelegate
- (void)introDidFinish:(EAIntroView *)introView {
    [super introDidFinish:introView];
    NSLog(@"introDidFinish callback");
    
    [self setupHomeViewController];
    
}


#pragma mark-Network
-(void)netAppLaunch
{
    //       [self.networkClient netSecurityCode:NET_USER_SECURITY_ID
    //                               delegate:self
    //                              didFinish:@selector(didNetSecurityCodeFinish:userInfo:)
    //                              didFailed:@selector(didNetSecurityCodeFailed:userInfo:)
    //                               userInfo:nil];
    
    [self.networkClient netAppLaunch:NET_APP_LAUNCH_ID delegate:self
                           didFinish:@selector(didNetAppLaunchFinish:userInfo:)
                           didFailed:@selector(didFailed:userInfo:)
                            userInfo:nil];

    
    
    
    
}

- (void)didNetAppLaunchFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"更新信息请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSDictionary class]]) {
                NSDictionary* infoDic =infoData;
                NSString* imgPath =infoDic[@"imgPath"]?infoDic[@"imgPath"]:@"";//启动图片地址
                NSString* resUrl =infoDic[@"resUrl"];//resUrl
                [self saveUserDefaultsNotNil:resUrl keyValue:APP_IMAGE_BASE_URL];
                
               
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
//            
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
//        [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//        
//    
//
//    
//}

#pragma mark-Network
-(void)netUserPersonInfo
{
    
    
    [self.networkClient netUserPersonInfo:NET_USER_PERSON_INFO_ID delegate:self
                                didFinish:@selector(didNetUserPersonInfoListFinish:userInfo:)
                                didFailed:@selector(didNetUserPersonInfoListFailed:userInfo:)
                                 userInfo:nil];
    
    
    
    
    
}

- (void)didNetUserPersonInfoListFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"个人信息信息请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
        }
        else
        {
            
            //登录初始化参数
            [self saveUserDefaultsNotNil:@"" keyValue:APP_LOGIN_TOKEN];
            [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_IMAGE];
            [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_URL];
            [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_TITLE_URL];
            [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_PHONE];
            
        }
    }
    else
    {
        //登录初始化参数
        [self saveUserDefaultsNotNil:@"" keyValue:APP_LOGIN_TOKEN];
        [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_IMAGE];
        [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_URL];
        [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_TITLE_URL];
        [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_PHONE];
    }
    
    
    
     [self performSelector:@selector(setupHomeViewController)];
    
}


- (void)didNetUserPersonInfoListFailed:(NSError *)error userInfo:(NSDictionary *)userInfo {
    DDDebug(@"个人信息查询失败%@", error);
    
    //登录初始化参数
    [self saveUserDefaultsNotNil:@"" keyValue:APP_LOGIN_TOKEN];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_IMAGE];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_URL];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_TITLE_URL];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_PHONE];
    
    
    [self performSelector:@selector(setupHomeViewController)];
    
}


@end
