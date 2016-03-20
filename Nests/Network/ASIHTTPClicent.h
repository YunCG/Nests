//
//  ASIHTTPClicent.h
//  Skeleton
//
//  Created by 🐠 on 1/25/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CQHttpClient.h"
#import "NetworkHelper.h"
@interface ASIHTTPClicent : CQHttpClient
//Test
- (void)httpClientTest:(NSString*)testName
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo;

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
            userInfo:(NSDictionary*)userInfo;
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
               userInfo:(NSDictionary*)userInfo;


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
            userInfo:(NSDictionary*)userInfo;
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
         userInfo:(NSDictionary*)userInfo;
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
                 userInfo:(NSDictionary*)userInfo;
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
                      userInfo:(NSDictionary*)userInfo;
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
                     userInfo:(NSDictionary*)userInfo;
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
                  userInfo:(NSDictionary*)userInfo;
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
              userInfo:(NSDictionary*)userInfo;
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
                       userInfo:(NSDictionary*)userInfo ;

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
                       userInfo:(NSDictionary*)userInfo;
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
                 userInfo:(NSDictionary*)userInfo;
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
             userInfo:(NSDictionary*)userInfo;
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
                userInfo:(NSDictionary*)userInfo;
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
                  userInfo:(NSDictionary*)userInfo;
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
                    userInfo:(NSDictionary*)userInfo;
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
               userInfo:(NSDictionary*)userInfo;

@end
