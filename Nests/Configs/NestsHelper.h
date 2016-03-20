//
//  NestsHelper.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NestsAMapKit.h"
#define  SharedNestsHelper  [NestsHelper sharedInstance]
@interface NestsHelper : NSObject
@property(nonatomic,retain)MAPointAnnotation* locationAnnotation;
+ (NestsHelper*)sharedInstance;
//获取应用程序的主窗口
-(UIWindow*)appKeyWindow;
//在本应用中打开的UIWindow列表
-(NSArray*)appWindows;
//是否离线下载
-(BOOL)isOffLine;
#pragma mark-用户信息
//是否登录
-(BOOL)isLoginApp;
//token
-(NSString*)userToken;
//phone
-(NSString*)userPhone;
//头像
-(NSString*)userImageUrl;
//自定义URL
-(NSString*)userDefineUrl;
-(NSString*)userDefineUrlTitle;
//图片资源地址
-(NSString*)imageBaseURL:(NSString*)imageURL;

@end
