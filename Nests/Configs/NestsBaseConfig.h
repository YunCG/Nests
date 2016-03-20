//
//  NestsBaseConfig.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#ifndef Nests_NestsBaseConfig_h
#define Nests_NestsBaseConfig_h
/******************************需要修改**********************/
#define APP_UDID_BUNDLE_IDENTIFIER  "com.score.user";//SvUDID（the "YOURAPPID" appear in two place, one in KeyChainAccessGroup.plist, another in SvUDIDTools.m）需要修改2个地方

/******************************XGPush**********************/
#define XG_SECRET_KEY @"d178eed780f28418ee8b90ee886d251f"
#define XG_ACCESS_KEY @"I3IUK51J83PY"
#define XG_ACCESS_ID  2200168662

#define XG_PUSH_TAG @"XG_PUSH_TAG_"
#define XG_PUSH_TAG_APP @"XG_PUSH_TAG_APP"
/******************************AMAP**********************/
#define MAMAP_APP_KEY @"41c52a90a981e902bc5d73b8bf9df726"
/****************************消息**********************/
#define NESTS_REFRESH_LEFT @"refresLeftInfo"//刷新左边界面

/******************************常用参数(替换)**********************/
#define NESTS_USER_ID  [SharedNestsHelper userPhone]//用户ID
#define NESTS_USER_TYPE  @"1"//1用户 2商家
#define NESTS_SHOPING_TYPE  @"2"// 2商家

#define NESTS_USER_TOKEN   [SharedNestsHelper userToken]//用户TOKEN
#define NESTS_OS_TYPE  @"1"//终端类型
#define NESTS_APP_VERSION  @"1.0.0"//应用版本号

#define NESTS_DEFAULT_LOCATION_LAT @"29.609523"
#define NESTS_DEFAULT_LOCATION_LON @"106.525994"

/******************************加载提示**********************/
#define NESTS_TIP_DEFAULT @"加载中。。。。"
#define NESTS_TIP_LOGIN @"登录中。。。。"

/******************************Debug**********************/
#define NESTS_USER_PHOTO  @"http://g.hiphotos.baidu.com/zhidao/pic/item/4afbfbedab64034f2e3168abafc379310b551d9a.jpg"



#endif
