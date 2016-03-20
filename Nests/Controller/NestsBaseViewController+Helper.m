//
//  NestsBaseViewController+Helper.m
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController+Helper.h"

@implementation NestsBaseViewController (Helper)


#pragma mark-跳转
//NestsRootViewController
-(void)navNestsRootViewController
{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsRootViewController] animated:YES];
    
}

//NestsHomeViewController
-(void)navNestsHomeViewController:(NESTS_CONTENT_ID)contentID
                             infoDic:(NSDictionary*)infoDic

{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsHomeViewController:contentID infoDic:infoDic] animated:YES];
    
}
//NestsAreaViewController
-(void)navNestsAreaViewController:(id)delegate

{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsAreaViewController:delegate] animated:YES];
    
}
//NestsScoreViewController
-(void)navNestsScoreViewController

{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsScoreViewController] animated:YES];
    
}



//NestsSettingViewController
-(void)navNestsSettingViewController
{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsSettingViewController] animated:YES];
    
}

//NestsMessageViewController
-(void)navNestsMessageViewController
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsMessageViewController] animated:YES];
    
}


//NestsEvaluateViewController
-(void)navNestsEvaluateViewController
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsEvaluateViewController] animated:YES];
    
}


//NestsPersonInfoViewController
-(void)navNestsPersonInfoViewController
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsPersonInfoViewController] animated:YES];
    
}
//NestsPersonInfoEditViewController
-(void)navNestsPersonInfoEditViewController:(CornerPersonInfoData*)dataSource
{
   
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsPersonInfoEditViewController:dataSource] animated:YES];
    
}


//NestsPersonInfoEditNameViewController
-(void)navNestsPersonInfoEditNameViewController:(CornerPersonInfoData*)dataSource
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsPersonInfoEditNameViewController:dataSource] animated:YES];
    
}

//NestsPersonInfoPhoneViewController
-(void)navNestsPersonInfoPhoneViewController:(CornerPersonInfoData*)dataSource
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsPersonInfoPhoneViewController:dataSource] animated:YES];
    
}
//NestsLoginViewController
-(void)navNestsLoginViewController:(BOOL)animated
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsLoginViewController] animated:animated];
    
}



//NestsEvaluateBIZViewController
-(void)navNestsEvaluateBIZViewController:(NSDictionary*)infoDataDic
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsEvaluateBIZViewController:infoDataDic] animated:YES];
    
}
//NestsEvaluateDetailViewController
-(void)navNestsEvaluateDetailViewController:(NSDictionary*)infoDataDic
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsEvaluateDetailViewController:infoDataDic] animated:YES];
    
}

//NestsParallaxViewController
-(void)navNestsParallaxViewController:(NSString*)mID
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsParallaxViewController:mID] animated:YES];
    
}


//NestsQRViewController
-(void)navNestsQRViewController
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsQRViewController] animated:YES];
    
}

//NestsListViewController
-(void)navNestsListViewController
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsListViewController] animated:YES];
    
}



//NestsMapViewController
-(void)navNestsMapViewController:(BOOL)isLocation
                    isShowNearby:(BOOL)isShowNearby
                        desPoint:(MAPointAnnotation*)desPoint
                       annotaitonArray:(NSArray*)annotaitonArray
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsMapViewController:isLocation isShowNearby:isShowNearby desPoint:desPoint annotaitonArray:annotaitonArray] animated:YES];
    
}

//NestsWebViewController
-(void)navNestsWebViewController:(NSDictionary*)infoDic
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsWebViewController:infoDic] animated:YES];
    
}

//NestsAppInfoViewController
-(void)navNestsAppInfoViewController:(NSDictionary*)infoDic
{
    
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsAppInfoViewController:infoDic] animated:YES];
    
}

//NestsOfflineDetailViewController
-(void)navNestsOfflineDetailViewController
{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsOfflineDetailViewController] animated:YES];
    
}



//NestsShopingAppraiseViewController
-(void)navNestsShopingAppraiseViewController:(NSDictionary*)infoDataDic
{
    [self.navigationController pushViewController:[SharedNestsSceneDispatch nestsShopingAppraiseViewController:infoDataDic] animated:YES];
    
}



@end
