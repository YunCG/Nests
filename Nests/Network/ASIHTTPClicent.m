//
//  ASIHTTPClicent.m
//  Skeleton
//
//  Created by 🐠 on 1/25/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "ASIHTTPClicent.h"


@implementation ASIHTTPClicent
- (void)httpClientTest:(NSString*)testName
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo {
  NSMutableDictionary* bodyDic = [[NSMutableDictionary alloc] init];
  [bodyDic setValue:@"4" forKey:@"callType"];
  [bodyDic setValue:@"1" forKey:@"currentPage"];
  [bodyDic setValue:@"5" forKey:@"pageSize"];

  NSURL* requestURL =
      [NSURL URLWithString:@"https://icard.njith.net/"
                           @"1001.json?clientid=1111&checksum=1111&stucode="
                           @"14CS001&stupsw=222222"];

  //    [self requestFromMode:requestURL netWorkRequestID:111 method:@"GET"
  //    reqStr:nil delegate:delegate didFinish:didFinish didFailed:didFailed
  //    userInfo:userInfo];

  [self requestFromGet:requestURL
      netWorkRequestID:111
               isCache:NO
         diskCachePath:nil
              delegate:delegate
             didFinish:didFinish
             didFailed:didFailed
              userInfo:userInfo];
  //    [self mobileNewestComAction:@"NewestComAction" currentPage:1 pageSize:1
  //    delegate:delegate didFinish:didFinish didFailed:didFailed
  //    userInfo:userInfo];
}

#pragma mark -Network Request
/**
 *  启动(检测更新也调用这个接口)
 *
 *  @param requestID NET_APP_LAUNCH_ID
 *
 */
- (void)netAppLaunch:(NET_REQUEST_ID)requestID
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    
    
    [bodyDic setValue:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setValue:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setValue:NESTS_OS_TYPE forKey:@"t"];
    //    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
//    [bodyDic setValue:cID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setValue:paramDic forKey:@"param"];
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_SECURITY_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}
/**
 *  获得验证码（I0001）
 *
 *  @param requestID NET_USER_SECURITY_ID
 *
 */
- (void)netSecurityCode:(NET_REQUEST_ID)requestID
                    cID:(NSString*)cID//手机号
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo {

  NSString* appURL = [SharedNetworkHelper netAppURL:requestID];

  NSURL* requestURL = [NSURL URLWithString:appURL];
  NSMutableDictionary* bodyDic =
      [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    
    
    [bodyDic setValue:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setValue:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setValue:NESTS_OS_TYPE forKey:@"t"];
//    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setValue:cID forKey:@"cId"];

    if (paramDic.count>0) {
        [bodyDic setValue:paramDic forKey:@"param"];
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_SECURITY_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}



/**
 *  登陆（I0002）
 *
 *  @param requestID NET_USER_LOGIN_ID
 *
 */
- (void)netUserLogin:(NET_REQUEST_ID)requestID
        securityCode:(NSString*)securityCode
                 cID:(NSString*)cID//手机号
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    securityCode =securityCode.trim;
    [paramDic setValue:securityCode forKey:@"code"];
    

    [bodyDic setValue:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setValue:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setValue:NESTS_OS_TYPE forKey:@"t"];
//    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setValue:cID forKey:@"cId"];
    
    if (paramDic.count>0) {
//        [bodyDic setObject:paramDic forKey:@"param"];
        [bodyDic setValue:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_LOGIN_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}



/**
 *  二维码（I0003）
 *
 *  @param requestID NET_USER_QR_ID
 *
 */
- (void)netUserQR:(NET_REQUEST_ID)requestID
            delegate:(id)delegate
           didFinish:(SEL)didFinish
           didFailed:(SEL)didFailed
            userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
//    [paramDic setObject:securityCode forKey:@"code"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_QR_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}


/**
 *  个人资料（I0004）
 *
 *  @param requestID NET_USER_PERSON_INFO_ID
 *
 */
- (void)netUserPersonInfo:(NET_REQUEST_ID)requestID
         delegate:(id)delegate
        didFinish:(SEL)didFinish
        didFailed:(SEL)didFailed
         userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    //    [paramDic setObject:securityCode forKey:@"code"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_PERSON_INFO_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}




/**
 *  修改头像（I0005）
 *
 *  @param requestID NET_USER_PERSON_PHOTO_ID
 *
 */
- (void)netUserPersonInfoPhoto:(NET_REQUEST_ID)requestID
                        imgStr:(NSString*)imgStr//发送base64字符串
                 delegate:(id)delegate
                didFinish:(SEL)didFinish
                didFailed:(SEL)didFailed
                 userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
       [paramDic setObject:imgStr forKey:@"imgStr"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_PERSON_PHOTO_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}



/**
 * 修改昵称（I0006）
 *
 *  @param requestID NET_USER_PERSON_NICKNAME_ID
 *
 */
- (void)netUserPersonNickName:(NET_REQUEST_ID)requestID
                  nickName:(NSString*)nickName
                      delegate:(id)delegate
                     didFinish:(SEL)didFinish
                     didFailed:(SEL)didFailed
                      userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    [paramDic setObject:nickName forKey:@"nickName"];
    
   
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_PERSON_NICKNAME_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}


/**
 * 修改手机号（I0007）
 *
 *  @param requestID NET_USER_PERSON_PHONE_ID
 *
 */
- (void)netUserPersonPhone:(NET_REQUEST_ID)requestID
                  newPhone:(NSString*)newPhone//新手机号
                 securityCode:(NSString*)securityCode//验证码(旧手机号获得的验证码)
                     code2:(NSString*)code2//验证码2(新手机号码获得的验证码)
                     delegate:(id)delegate
                    didFinish:(SEL)didFinish
                    didFailed:(SEL)didFailed
                     userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
       [paramDic setObject:newPhone forKey:@"newPhone"];
      [paramDic setObject:securityCode forKey:@"code"];
      [paramDic setObject:code2 forKey:@"code2"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_PERSON_PHONE_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}




/**
 * 退出（I0008）
 *
 *  @param requestID NET_USER_SING_OUT_ID
 *
 */
- (void)netUserSingOut:(NET_REQUEST_ID)requestID
                  delegate:(id)delegate
                 didFinish:(SEL)didFinish
                 didFailed:(SEL)didFailed
                  userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    //    [paramDic setObject:securityCode forKey:@"code"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_USER_SING_OUT_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}



/**
 * 获取商家列表（M0001）
 *
 *  @param requestID NET_MER_SHOPINGKEPPER_LIST_ID
 *
 */
- (void)netMerShopingkepperList:(NET_REQUEST_ID)requestID
                           type:(NSString*)type//map:0 list:1
                            lat:(NSString*)lat//纬度
                            lon:(NSString*)lon//经度
                         region:(NSString*)region//区域1
                        region2:(NSString*)region2//区域1
                        region3:(NSString*)region3//区域1
                          name :(NSString*)name//商家名称
                       pageSize:(int)pageSize//每页显示数目
                        pageNum:(int)pageNum //页码
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
     [paramDic setValue:type forKey:@"type"];
     [paramDic setValue:lon forKey:@"lng"];
     [paramDic setValue:lat forKey:@"lat"];
     [paramDic setValue:region forKey:@"region"];
     [paramDic setValue:region2 forKey:@"region2"];
     [paramDic setValue:region3 forKey:@"region3"];
     [paramDic setValue:name forKey:@"name"];
     [paramDic setValue:[NSString stringWithFormat:@"%d",pageSize]  forKey:@"pageSize"];
     [paramDic setValue:[NSString stringWithFormat:@"%d",pageNum] forKey:@"pageNum"];
    
    
    
    [bodyDic setValue:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setValue:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setValue:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setValue:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setValue:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setValue:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_SHOPINGKEPPER_LIST_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}


/**
 * 获取商家详情（M0002）
 *
 *  @param requestID NET_MER_SHOPINGKEPPER_INFO_ID
 *
 */
- (void)netMerShopingkepperInfo:(NET_REQUEST_ID)requestID
                            mId:(NSString*)mId//商家ID
                       delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
       [paramDic setObject:mId forKey:@"mId"];
    
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_SHOPINGKEPPER_INFO_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}


/**
 * 商家全部评价（M0003）
 *
 *  @param requestID NET_MER_EVALUATE_ALL_ID
 *
 */
- (void)netMerEvaluateAll:(NET_REQUEST_ID)requestID
                            mId:(NSString*)mId//商家ID
                       pageSize:(NSNumber*)pageSize//每页显示数目
                        pageNum:(NSNumber*)pageNum //页码
                       delegate:(id)delegate
                      didFinish:(SEL)didFinish
                      didFailed:(SEL)didFailed
                       userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    [paramDic setObject:mId forKey:@"mId"];
    [paramDic setObject:pageSize forKey:@"pageSize"];
    [paramDic setObject:pageNum forKey:@"pageNum"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_EVALUATE_ALL_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}





/**
 * 我的积分（M0004）
 *
 *  @param requestID NET_MER_SCORE_ID
 *
 */
- (void)netMerScoreID:(NET_REQUEST_ID)requestID
                      flag:(NSString*)flag//积分标志(1、可用积分 2、已消费积分 3、过期积分)
                 pageSize:(NSNumber*)pageSize//每页显示数目
                  pageNum:(NSNumber*)pageNum //页码
                 delegate:(id)delegate
                didFinish:(SEL)didFinish
                didFailed:(SEL)didFailed
                 userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    [paramDic setObject:flag forKey:@"flag"];
    [paramDic setObject:pageSize forKey:@"pageSize"];
    [paramDic setObject:pageNum forKey:@"pageNum"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_SCORE_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}


/**
 * 评价（M0005）
 *
 *  @param requestID NET_MER_EVALUATE_ID
 *
 */
- (void)netMerEvaluateID:(NET_REQUEST_ID)requestID
                 consumeId:(NSString*)consumeId//消费ID
             score:(NSNumber*)score//评价分数
              content:(NSString*)content //评价内容
                delegate:(id)delegate
            didFinish:(SEL)didFinish
            didFailed:(SEL)didFailed
             userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    [paramDic setObject:consumeId forKey:@"consumeId"];
    [paramDic setObject:score forKey:@"score"];
    [paramDic setObject:content forKey:@"content"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_EVALUATE_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}




/**
 * 我的积分（M0004）
 *
 *  @param requestID NET_MER_EVALUATE_MINE_ID
 *
 */
- (void)netMerEvaluateMine:(NET_REQUEST_ID)requestID
                 flag:(NSString*)flag//积分标志(1、待评价 2、已评价 )
             pageSize:(NSNumber*)pageSize//每页显示数目
              pageNum:(NSNumber*)pageNum //页码
             delegate:(id)delegate
            didFinish:(SEL)didFinish
            didFailed:(SEL)didFailed
             userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    [paramDic setObject:flag forKey:@"flag"];
    [paramDic setObject:pageSize forKey:@"pageSize"];
    [paramDic setObject:pageNum forKey:@"pageNum"];
    
    
    
    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_EVALUATE_MINE_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}



/**
 * 评价详情（M0007）
 *
 *  @param requestID NET_MER_EVALUATE_DETAIL_ID
 *
 */
- (void)netMerEvaluateDetail:(NET_REQUEST_ID)requestID
                      consumeId:(NSString*)consumeId//消费ID
                                delegate:(id)delegate
                 didFinish:(SEL)didFinish
                 didFailed:(SEL)didFailed
                  userInfo:(NSDictionary*)userInfo {
    
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    
    NSURL* requestURL = [NSURL URLWithString:appURL];
    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary* paramDic =[[NSMutableDictionary alloc] initWithCapacity:1];
    
    [paramDic setObject:consumeId forKey:@"consumeId"];

    [bodyDic setObject:NESTS_APP_VERSION forKey:@"v"];
    [bodyDic setObject:NESTS_USER_TYPE forKey:@"u"];
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    
    if (paramDic.count>0) {
        [bodyDic setObject:paramDic forKey:@"param"];
        
    }
    
    
    [self requestFromMode:requestURL netWorkRequestID:NET_MER_EVALUATE_DETAIL_ID method:@"POST" reqDic:bodyDic delegate:delegate
                didFinish:didFinish
                didFailed:didFailed
                 userInfo:userInfo];
    
    
}





/**
 *  SQLITE数据下载
 *
 *  @param URLString       NET_DOWND_SQLLITE
 *  @param fileName        下载文件名字
 *  @param destinationPath  文件下载目标文件夹

 */
- (void)netDownloadFile:(NET_REQUEST_ID)requestID
            fileName:(NSString*)fileName
        destinationPath:(NSString*)destinationPath
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo {
    NSString* appURL = [SharedNetworkHelper netAppURL:requestID];
    NSString* downFilePath =[NSString stringWithFormat:@"%@?t=%@&tk=%@&cId=%@",appURL,NESTS_OS_TYPE,NESTS_USER_TOKEN,NESTS_USER_ID];
    NSURL* requestURL = [NSURL URLWithString:downFilePath];

    NSMutableDictionary* bodyDic =
    [[NSMutableDictionary alloc] initWithCapacity:1];

    
    [bodyDic setObject:NESTS_OS_TYPE forKey:@"t"];
    [bodyDic setObject:NESTS_USER_TOKEN forKey:@"tk"];
    [bodyDic setObject:NESTS_USER_ID forKey:@"cId"];
    

    
      [self requestFromPost:requestURL
           netWorkRequestID:NET_DOWND_SQLLITE_ID
          dictionaryForText:nil
                 keyForFile:nil
                   delegate:delegate
                  didFinish:didFinish
                  didFailed:didFailed
                   userInfo:userInfo];
    
    NSString* destinationFile =[NSString stringWithFormat:@"%@/%@",destinationPath,fileName];
    NSString* temporaryFile =[SharedNetworkHelper dowLoadTempleFile:fileName];
    
    [self startDownloadFile:requestURL netWorkRequestID: NET_DOWND_SQLLITE_ID destinationFile:destinationFile temporaryFile:temporaryFile progressView:nil delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];
    
    
    
 
}




@end
