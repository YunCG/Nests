//
//  NestsConfig.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#ifndef Nests_NestsConfig_h
#define Nests_NestsConfig_h
#pragma mark-LOG
/***************************************Log*******************************************************************/
static const int ddLogLevel = LOG_LEVEL_VERBOSE;//log Level
#define DDDLog(fmt, ...)     DDLogVerbose((@"%s [DDLogInfo Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);//Verbose
#define DDError(fmt, ...)    DDLogError((@"%s [Error Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);//错误
#define DDWarn(fmt, ...)     DDLogWarn((@"%s [Warn Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);//警告
#define DDDebug(fmt, ...)    DDLogDebug((@"%s [Debug Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);//Debug
#define DDInfo(fmt, ...)     DDLogInfo((@"%s [DDLogInfo Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);//Info

#pragma mark-自定义字体
#define  APP_FONT_DIGITAL @"Digital-7Mono"//倒计时字体（digital-7.ttf）
#define APP_FONT_POKER @"329-CAI978"//扑克牌字体（birthday.ttf）

#pragma mark-Localized
/**************************************************Localized***************************************************/
#define LocalString(key, comment)  NSLocalizedStringFromTable(key, @"Localizable", comment)

/****************************App信息************************/
#define APP_FIRST_LANCH @"app_first_lanch"//第一次登陆
#define APP_NOT_FIRST_LANCH @"app_not_first_lanch"//不是第一次登陆

#define APP_IMAGE_BASE_URL @"app_image_base_url"//默认图片
#define APP_DEFAULT_IMAGE @"default_image"//默认图片
#define  APP_OFFLINE_BTN  @"app_offline_btn"//wifi下载
/****************************UserDefaults************************/
#define APP_IS_LOGIN    @"app_is_login"//是否登陆
#define APP_USER_SELECT_MODEL @"app_user_select_model"//用户选择的模式
#define  APP_LOGIN_TOKEN  @"app_login_token"//用户token

#define  APP_IS_SAVE_LOGIN  @"app_is_save_login"//是否保存登录


#define  APP_USER_PHONE @"app_user_phone"//用户名
#define  APP_USER_IMAGE  @"app_user_image"//用户头像
#define  APP_USER_URL  @"app_user_url"//用户URL
#define  APP_USER_TITLE_URL  @"app_user_title_url"//用户URL名称
#define  APP_USER_LOCATION  @"app_user_location"//用户位置
#define  APP_USER_LOCATION_LAT  @"app_user_location_lat"//用户位置
#define  APP_USER_LOCATION_LON  @"app_user_location_lon"//用户位置
#define  APP_USER_LOCATION_TITLE  @"app_user_location_title"//用户位置
#define  APP_USER_LOCATION_SUBTITLE  @"app_user_location_subTitle"//用户位置

/******************************提示**********************/
#define APP_SERVER_DEFAULT_TIP @"服务器返回错误"
#define APP_SERVER_INFO_TIP @"信息获取失败"
#define APP_USER_LOGIN_TIP @"登录失败"
#define APP_NETWORK_DEFAULT_ARRER @"网络连接失败,请查看网络连接"

#define APP_LOCATION_ERROR_TIP @"定位失败"

#define APP_NORMAL_STATE  0


typedef  enum{

    APP_SERVER_ERROR_SEVER_DEFAULT_CODE =10000,
    APP_SERVER_ERROR_SEVER_INFO_CODE =10001,
    
     APP_SERVER_ERROR_LOGIN_CODE =20000,
    
    APP_SERVER_CODE =30000,
    
    
    APP_LOCATION_ERROR_CODE =80000,
     APP_SERVER_ERROR_NETWORK_DEFAULT_CODE =90000,

    
} APP_SERVER_ERROR_CODE;

/******************************Sqllite**********************/
#define  APP_SQLLITE_DB   @"NestsSqllite.db"
#define  APP_SQLLITE_MESSAGE_TABLE   @"NestsMessageTable"
#define  APP_SERVER_DB   @"NestsServer.db"
////查询城市
//#define  SQL_CITY   @"SELECT DISTINCT provinceId,provinceCode,provinceName from tb_street"
////查询商圈
//#define  SQL_DISTRICT    @"SELECT DISTINCT areaId,areaName from tb_street WHERE provinceId ='%@'"
//////查询街道
//#define  SQL_STREET  @"SELECT DISTINCT streetID,streetName from tb_street WHERE areaId ='%@'"
//XGPush DB
//#define  SQL_APP_CREATE_PUSH_TABLE @"create table NestsMessageTable (id integer primary key autoincrement, messages text,isRead text,createdTime TimeStamp NOT NULL DEFAULT(datetime('now','localtime')));"
//#define  SQL_PUSH_QUERY  @"select * from NestsMessageTable  order by createdTime desc"
//#define  SQL_PUSH_INSERT  @"INSERT INTO NestsMessageTable(messages) VALUES('%@');"
//#define  SQL_PUSH_DELETE @"delete from NestsMessageTable;"//清空表
//#define  SQL_IS_EXIST_TABLE @"SELECT COUNT(*) FROM sqlite_master where type='table' and name='NestsMessageTable'"



#endif
