//
//  NestsSceneDispatch.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsSceneDispatch.h"

@implementation NestsSceneDispatch
+ (id)sharedInstance {
    // 1
    static NestsSceneDispatch* _sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NestsSceneDispatch alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - RootNavigationController
// rootNavigation
- (id)rootNavigationController {
   
    DDInfo(@"Lunch App Success💐💐💐💐💐💐💐💐💐.==");
    //去掉导航阴影线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
   UINavigationController* navigationController = [[UINavigationController alloc]
                                     initWithRootViewController:[self nestsRootViewController]];
    //    [self.baseNavigationController setNavigationBarHidden:YES animated:NO];
   
    return  navigationController;

}

//baseNavigation
- (id)baseNavigationController {
    
    DDInfo(@"Lunch App Success💐💐💐💐💐💐💐💐💐.==");
    //去掉导航阴影线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    UINavigationController* navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:[self nestsHomeViewController:NESTS_CONTENT_ID_DEFAULT infoDic:nil]];
    //    [self.baseNavigationController setNavigationBarHidden:YES animated:NO];
    
    return  navigationController;
    
}

#pragma mark-ViewController
// NestsRootViewController
- (id)nestsRootViewController
{
    DDInfo(@"Enter NestsRootViewController");
    NestsRootViewController* controller =
    [[NestsRootViewController alloc] init];
    return controller;
}

//NestsHomeViewController
- (id)nestsHomeViewController:(NESTS_CONTENT_ID)contentID
                         infoDic:(NSDictionary*)infoDic
{
    DDInfo(@"Enter NestsHomeViewController");
    NestsHomeViewController* controller =
    [[NestsHomeViewController alloc] init];
    controller.contentID =contentID;
    controller.infoDic =infoDic;
    
    
    return controller;
}

//NestsAreaViewController
- (id)nestsAreaViewController:(id)delegate
{
    DDInfo(@"Enter NestsAreaViewController");
    NestsAreaViewController* controller =
    [[NestsAreaViewController alloc] init];
    controller.delegate =delegate;
    
    
    return controller;
}
//NestsScoreViewController
- (id)nestsScoreViewController
{
    DDInfo(@"Enter NestsScoreViewController");
    NestsScoreViewController* controller =
    [[NestsScoreViewController alloc] init];
    
    
    return controller;
}

//NestsSettingViewController
- (id)nestsSettingViewController
{
    DDInfo(@"Enter NestsSettingViewController");
    NestsSettingViewController* controller =
    [[NestsSettingViewController alloc] init];
    
    
    return controller;
}

//NestsMessageViewController
- (id)nestsMessageViewController
{
    DDInfo(@"Enter NestsMessageViewController");
    NestsMessageViewController* controller =
    [[NestsMessageViewController alloc] init];
    return controller;
}

//NestsEvaluateViewController
- (id)nestsEvaluateViewController
{
    DDInfo(@"Enter NestsEvaluateViewController");
    NestsEvaluateViewController* controller =
    [[NestsEvaluateViewController alloc] init];
    return controller;
}

//NestsPersonInfoViewController
- (id)nestsPersonInfoViewController
{
    DDInfo(@"Enter NestsPersonInfoViewController");
    NestsPersonInfoViewController* controller =
    [[NestsPersonInfoViewController alloc] init];
    return controller;
}

//NestsPersonInfoEditViewController
- (id)nestsPersonInfoEditViewController:(CornerPersonInfoData*)dataSource
{
    DDInfo(@"Enter NestsPersonInfoEditViewController");
    NestsPersonInfoEditViewController* controller =
    [[NestsPersonInfoEditViewController alloc] init];
    
    controller.dataSource =dataSource;
    return controller;
}
//NestsPersonInfoEditNameViewController
- (id)nestsPersonInfoEditNameViewController:(CornerPersonInfoData*)dataSource
{
    DDInfo(@"Enter NestsPersonInfoEditNameViewController");
    NestsPersonInfoEditNameViewController* controller =
    [[NestsPersonInfoEditNameViewController alloc] init];
    controller.dataSource =dataSource;
    return controller;
}
//NestsPersonInfoPhoneViewController
- (id)nestsPersonInfoPhoneViewController:(CornerPersonInfoData*)dataSource
{
    DDInfo(@"Enter NestsPersonInfoPhoneViewController");
    NestsPersonInfoPhoneViewController* controller =
    [[NestsPersonInfoPhoneViewController alloc] init];
      controller.dataSource =dataSource;
    return controller;
}
//NestsLoginViewController
- (id)nestsLoginViewController
{
    DDInfo(@"Enter NestsLoginViewController");
    NestsLoginViewController* controller =
    [[NestsLoginViewController alloc] init];
    return controller;
}

//NestsEvaluateBIZViewController
- (id)nestsEvaluateBIZViewController:(NSDictionary*)infoDataDic
{
    DDInfo(@"Enter NestsEvaluateBIZViewController");
    NestsEvaluateBIZViewController* controller =
    [[NestsEvaluateBIZViewController alloc] init];
    
    controller.infoDataDic =infoDataDic;
  
    return controller;
}

//NestsEvaluateDetailViewController
- (id)nestsEvaluateDetailViewController:(NSDictionary*)infoDataDic
{
    DDInfo(@"Enter NestsEvaluateDetailViewController");
    NestsEvaluateDetailViewController* controller =
    [[NestsEvaluateDetailViewController alloc] init];
    
    controller.infoDataDic =infoDataDic;
    
    return controller;
}



//NestsParallaxViewController
- (id)nestsParallaxViewController:(NSString*)mID
{
    DDInfo(@"Enter NestsParallaxViewController");
    NestsParallaxViewController* controller =
    [[NestsParallaxViewController alloc] init];
    controller.mID =mID;
    return controller;
}

//NestsQRViewController
- (id)nestsQRViewController
{
    DDInfo(@"Enter NestsQRViewController");
    NestsQRViewController* controller =
    [[NestsQRViewController alloc] init];
    return controller;
}
//NestsListViewController
- (id)nestsListViewController
{
    DDInfo(@"Enter NestsListViewController");
    NestsListViewController* controller =
    [[NestsListViewController alloc] init];
    return controller;
}

//NestsMapViewController
- (id)nestsMapViewController:(BOOL)isLocation
                isShowNearby:(BOOL)isShowNearby
                    desPoint:(MAPointAnnotation*)desPoint
                   annotaitonArray:(NSArray*)annotaitonArray
{
    DDInfo(@"Enter NestsMapViewController");
    NestsMapViewController* controller =
    [[NestsMapViewController alloc] init];
    controller.isLocation =isLocation;
    controller.isShowNearby =isShowNearby;
    controller.annotaitonArray =annotaitonArray;
    controller.desPoint =desPoint;
    return controller;
}

//NestsWebViewController
- (id)nestsWebViewController:(NSDictionary*)infoDic
{
    DDInfo(@"Enter NestsWebViewController");
    NestsWebViewController* controller =
    [[NestsWebViewController alloc] init];
    controller.infoDic =infoDic;
    
    return controller;
}

//NestsAppInfoViewController
- (id)nestsAppInfoViewController:(NSDictionary*)infoDic
{
    DDInfo(@"Enter NestsAppInfoViewController");
    NestsAppInfoViewController* controller =
    [[NestsAppInfoViewController alloc] init];
    
    return controller;
}


//NestsOfflineDetailViewController
- (id)nestsOfflineDetailViewController
{
    DDInfo(@"Enter NestsOfflineDetailViewController");
    NestsOfflineDetailViewController* controller =
    [[NestsOfflineDetailViewController alloc] init];
    return controller;
}


//NestsShopingAppraiseViewController
- (id)nestsShopingAppraiseViewController:(NSDictionary*)infoDataDic
{
    DDInfo(@"Enter NestsShopingAppraiseViewController");
    NestsShopingAppraiseViewController* controller =
    [[NestsShopingAppraiseViewController alloc] init];
    controller.infoDataDic =infoDataDic;
    return controller;
}




#pragma mark- NestsRESideMenu

- (id)nestsRESideMenuViewController:(id<RESideMenuDelegate>)delegate
{

//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[NestsResideMenuFirstViewController alloc] init]];
    NestsResideMenuLeftMenuViewController *leftMenuViewController = [[NestsResideMenuLeftMenuViewController alloc] init];
//    NestsResideMenuRightMenuViewController *rightMenuViewController = [[NestsResideMenuRightMenuViewController alloc] init];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: [self nestsHomeViewController:NESTS_CONTENT_ID_DEFAULT infoDic:nil]];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"nestsResideMenu_zone_bg"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    
    return sideMenuViewController;

}
#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController: %@", NSStringFromClass([menuViewController class]));
    
     [[NSNotificationCenter defaultCenter] postNotificationName:NESTS_REFRESH_LEFT object:nil];
    
    
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



@end
