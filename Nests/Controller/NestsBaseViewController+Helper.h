//
//  NestsBaseViewController+Helper.h
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController.h"
#import "CornerPersonInfoData.h"
@interface NestsBaseViewController (Helper)
//NestsRootViewController
-(void)navNestsRootViewController;
//NestsHomeViewController
-(void)navNestsHomeViewController:(NESTS_CONTENT_ID)contentID
                              infoDic:(NSDictionary*)infoDic;
//NestsAreaViewController
-(void)navNestsAreaViewController:(id)delegate;
//NestsScoreViewController
-(void)navNestsScoreViewController;
//NestsSettingViewController
-(void)navNestsSettingViewController;
//NestsMessageViewController
-(void)navNestsMessageViewController;
//NestsEvaluateViewController
-(void)navNestsEvaluateViewController;
//NestsPersonInfoViewController
-(void)navNestsPersonInfoViewController;
//NestsPersonInfoEditViewController
-(void)navNestsPersonInfoEditViewController:(CornerPersonInfoData*)dataSource;
//NestsPersonInfoEditNameViewController
-(void)navNestsPersonInfoEditNameViewController:(CornerPersonInfoData*)dataSource;
//NestsPersonInfoPhoneViewController
-(void)navNestsPersonInfoPhoneViewController:(CornerPersonInfoData*)dataSource;
//NestsLoginViewController
-(void)navNestsLoginViewController:(BOOL)animated;
//NestsEvaluateBIZViewController
-(void)navNestsEvaluateBIZViewController:(NSDictionary*)infoDataDic;
//NestsEvaluateDetailViewController
-(void)navNestsEvaluateDetailViewController:(NSDictionary*)infoDataDic;
//NestsParallaxViewController
-(void)navNestsParallaxViewController:(NSString*)mID;
//NestsQRViewController
-(void)navNestsQRViewController;
//NestsListViewController
-(void)navNestsListViewController;
//NestsMapViewController
-(void)navNestsMapViewController:(BOOL)isLocation
                    isShowNearby:(BOOL)isShowNearby
                        desPoint:(MAPointAnnotation*)desPoint
                 annotaitonArray:(NSArray*)annotaitonArray;
//NestsWebViewController
-(void)navNestsWebViewController:(NSDictionary*)infoDic;
//NestsAppInfoViewController
-(void)navNestsAppInfoViewController:(NSDictionary*)infoDic;
//NestsOfflineDetailViewController
-(void)navNestsOfflineDetailViewController;
//NestsShopingAppraiseViewController
-(void)navNestsShopingAppraiseViewController:(NSDictionary*)infoDataDic;
@end
