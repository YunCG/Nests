//
//  NestsSceneDispatch.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NestsBaseViewController.h"
#import "NestsRootViewController.h"
#include "RESideMenu.h"
#import "NestsHomeViewController.h"
#import "NestsSettingViewController.h"
#import "NestsMessageViewController.h"
#import "NestsEvaluateViewController.h"

#import "NestsPersonInfoViewController.h"
#import "NestsPersonInfoEditViewController.h"
#import "NestsPersonInfoPhoneViewController.h"
#import "NestsLoginViewController.h"

#import "NestsResideMenuLeftMenuViewController.h"
#import "NestsResideMenuRightMenuViewController.h"
#import "NestsResideMenuFirstViewController.h"
#import "NestsPersonInfoEditNameViewController.h"

#import "NestsScoreViewController.h"
#import "NestsEvaluateBIZViewController.h"

#import "NestsParallaxViewController.h"

#import "NestsQRViewController.h"
#import "NestsListViewController.h"
#import "NestsMapViewController.h"
#import "NestsWebViewController.h"
#import "NestsOfflineDetailViewController.h"
#import "NestsAreaViewController.h"
#import "NestsShopingAppraiseViewController.h"
#import "NestsEvaluateDetailViewController.h"
#import "NestsAppInfoViewController.h"

#define  SharedNestsSceneDispatch  [NestsSceneDispatch sharedInstance]
@interface NestsSceneDispatch : NSObject<RESideMenuDelegate>

#pragma mark-init
//init
+ (id)sharedInstance;
#pragma mark - RootNavigationController
// rootNavigation
- (id)rootNavigationController;
//baseNavigation
- (id)baseNavigationController;
#pragma mark-ViewController
// NestsRootViewController
- (id)nestsRootViewController;
//NestsHomeViewController
- (id)nestsHomeViewController:(NESTS_CONTENT_ID)contentID
                        infoDic:(NSDictionary*)infoDic;
//NestsAreaViewController
- (id)nestsAreaViewController:(id)delegate;
//NestsScoreViewController
- (id)nestsScoreViewController;
//NestsSettingViewController
- (id)nestsSettingViewController;
//NestsMessageViewController
- (id)nestsMessageViewController;
//NestsEvaluateViewController
- (id)nestsEvaluateViewController;
//NestsPersonInfoViewController
- (id)nestsPersonInfoViewController;
//NestsPersonInfoEditViewController
- (id)nestsPersonInfoEditViewController:(CornerPersonInfoData*)dataSource;
//NestsPersonInfoEditNameViewController
- (id)nestsPersonInfoEditNameViewController:(CornerPersonInfoData*)dataSource;
//NestsPersonInfoPhoneViewController
- (id)nestsPersonInfoPhoneViewController:(CornerPersonInfoData*)dataSource;
//NestsLoginViewController
- (id)nestsLoginViewController;
//NestsEvaluateBIZViewController
- (id)nestsEvaluateBIZViewController:(NSDictionary*)infoDataDic;
//NestsEvaluateDetailViewController
- (id)nestsEvaluateDetailViewController:(NSDictionary*)infoDataDic;
//NestsParallaxViewController
- (id)nestsParallaxViewController:(NSString*)mID;
//NestsQRViewController
- (id)nestsQRViewController;
//NestsListViewController
- (id)nestsListViewController;
//NestsMapViewController
- (id)nestsMapViewController:(BOOL)isLocation
                isShowNearby:(BOOL)isShowNearby
                    desPoint:(MAPointAnnotation*)desPoint
                   annotaitonArray:(NSArray*)annotaitonArray;
//NestsWebViewController
- (id)nestsWebViewController:(NSDictionary*)infoDic;
//NestsOfflineDetailViewController
- (id)nestsOfflineDetailViewController;
//NestsShopingAppraiseViewController
- (id)nestsShopingAppraiseViewController:(NSDictionary*)infoDataDic;
// NestsRESideMenu
- (id)nestsRESideMenuViewController:(id<RESideMenuDelegate>)delegate;

//NestsAppInfoViewController
- (id)nestsAppInfoViewController:(NSDictionary*)infoDic;

@end
