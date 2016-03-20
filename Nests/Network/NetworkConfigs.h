//
//  NetworkConfigs.h
//  Skeleton
//
//  Created by 🐠 on 3/16/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#ifndef Skeleton_NetworkConfigs_h
#define Skeleton_NetworkConfigs_h

/********************************BaseURL*********************************************/
#define NET_BASE_URL @"http://139.196.20.168/m/termService"

#define NET_WEB_BASE_URL @"http://139.196.20.168/mng/msgService"//WEBView
/********************************系统固定参数*********************************************/

typedef enum {
    //启动(检测更新也调用这个接口)
    NET_APP_LAUNCH_ID =0,
    //获得验证码（I0001）
    NET_USER_SECURITY_ID =1,
    //登陆（I0002）
    NET_USER_LOGIN_ID =2,
    //二维码（I0003）
    NET_USER_QR_ID =3,
    //个人资料（I0004）
    NET_USER_PERSON_INFO_ID =4,
    //修改头像（I0005）
    NET_USER_PERSON_PHOTO_ID =5,
    //修改昵称（I0006）
    NET_USER_PERSON_NICKNAME_ID =6,
    //修改手机号（I0007）
   NET_USER_PERSON_PHONE_ID =7,
    //退出（I0008）
    NET_USER_SING_OUT_ID =8,
    
    
    //获取商家列表（M0001）
    NET_MER_SHOPINGKEPPER_LIST_ID =51,
    //获取商家详情（M0002）
    NET_MER_SHOPINGKEPPER_INFO_ID =52,
    //商家全部评价（M0003）
    NET_MER_EVALUATE_ALL_ID =53,
    //我的积分（M0004）
    NET_MER_SCORE_ID =54,
    //评价（M0005）
   NET_MER_EVALUATE_ID =55,
    //我的评价（M0006）
   NET_MER_EVALUATE_MINE_ID =56,
    //评价详情（M0007）
   NET_MER_EVALUATE_DETAIL_ID =57,

    //SQLITE数据下载（T0024）
    NET_DOWND_SQLLITE_ID            		=100,//所有下载的ID

}NET_REQUEST_ID;

/********************************系统接口*********************************************/

#define  NET_APP_LAUNCH_PATH @"/loadApp.bd"
//获得验证码（I0001）
#define NET_USER_SECURITY_PATH @"/I0001/user.bd"
//登陆（I0002）
#define NET_USER_LOGIN_PATH @"/I0002/user.bd"
//二维码（I0003）
#define NET_USER_QR_PATH @"/I0003/user.bd"
//个人资料（I0004）
#define NET_USER_PERSON_INFO_PATH @"/I0004/user.bd"
//修改头像（I0005）
#define NET_USER_PERSON_PHOTO_PATH @"/I0005/user.bd"
//修改昵称（I0006）
#define NET_USER_PERSON_NICKNAME_PATH @"/I0006/user.bd"
//修改手机号（I0007）
#define NET_USER_PERSON_PHONE_PATH @"/I0007/user.bd"
//退出（I0008）
#define NET_USER_SING_OUT_PATH @"/I0008/user.bd"

//获取商家列表（M0001））
#define NET_MER_SHOPINGKEPPER_LIST_PATH @"/M0001/merchant.bd"
//获取商家详情（M0002）
#define NET_MER_SHOPINGKEPPER_INFO_PATH @"/M0002/merchant.bd"
//商家全部评价（M0003）
#define NET_MER_EVALUATE_ALL_PATH @"/M0003/merchant.bd"
//我的积分（M0004）
#define NET_MER_SCORE_PATH @"/M0004/merchant.bd"
//评价（M0005）
#define NET_MER_EVALUATE_PATH @"/M0005/merchant.bd"
//我的评价（M0006）
#define NET_MER_EVALUATE_MINE_PATH @"/M0006/merchant.bd"
//评价详情（M0007）
#define NET_MER_EVALUATE_DETAIL_PATH @"/M0007/merchant.bd"




//SQLITE数据下载（18）
#define NET_DOWND_SQLLITE_PATH  @"/down.bd"
/********************************系统接口*********************************************/

#endif
