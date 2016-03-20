//
//  NestsHelper.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsHelper.h"

@implementation NestsHelper
+ (NestsHelper*)sharedInstance
{
    // 1
    static NestsHelper *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NestsHelper alloc] init];
    });
    return _sharedInstance;
}

//获取应用程序的主窗口
-(UIWindow*)appKeyWindow
{
    UIWindow* window =[UIApplication sharedApplication].keyWindow;
    return window;
    
}
//在本应用中打开的UIWindow列表
-(NSArray*)appWindows
{
    NSArray* windows =[UIApplication sharedApplication].windows;
    return windows;
    
}

//是否离线下载
-(BOOL)isOffLine
{
    BOOL isEnable =YES;
    
     NSString *isOffLine =[self objectForUserDefaults:APP_OFFLINE_BTN]?[self objectForUserDefaults:APP_OFFLINE_BTN]:@"" ;
    
    if ([isOffLine isKindOfClass:[NSString class]]&&([isOffLine  isEqualToString:APP_OFFLINE_BTN])) {
        isEnable =NO;
    }
    
    return isEnable;

}
#pragma mark-用户信息
//是否登录
-(BOOL)isLoginApp
{
    BOOL isLogin =NO;
    
    NSString* token =[self userToken];
    BOOL isSave =[self isSaveLogin];
    if (token.length>1&&isSave) {
        isLogin =YES;
        
    }
    
    
    return isLogin;
}

//token
-(NSString*)userToken
{
    NSString *token =[self objectForUserDefaults:APP_LOGIN_TOKEN]?[self objectForUserDefaults:APP_LOGIN_TOKEN]:@"" ;
    DDDLog(@"token====%@",token);
    return token;
}

//isSaveLogin
-(BOOL)isSaveLogin
{
    BOOL isSave =NO;
    NSString *login =[self objectForUserDefaults:APP_IS_SAVE_LOGIN];
    
    if ([login isKindOfClass:[NSString class]]) {
        isSave =login.boolValue;
    }
    
    
    DDDLog(@"isSave====%d",isSave);
    return isSave;
}

//phone
-(NSString*)userPhone
{
    NSString *phone =[self objectForUserDefaults:APP_USER_PHONE]?[self objectForUserDefaults:APP_USER_PHONE]:@"" ;
    DDDLog(@"phone====%@",phone);
    return phone;
}
//头像
-(NSString*)userImageUrl
{
    NSString *image =[self objectForUserDefaults:APP_USER_IMAGE]?[self objectForUserDefaults:APP_USER_IMAGE]:@"" ;
    DDDLog(@"image====%@",image);
    
    NSString* baseUrl =[self imageBaseURL:image];
    
    return baseUrl;
}

//自定义URL
-(NSString*)userDefineUrl
{
    NSString *defineUrl =[self objectForUserDefaults:APP_USER_URL]?[self objectForUserDefaults:APP_USER_URL]:@"" ;
    DDDLog(@"defineUrl====%@",defineUrl);
    return defineUrl;
}

-(NSString*)userDefineUrlTitle
{
    NSString *defineUrl =[self objectForUserDefaults:APP_USER_TITLE_URL]?[self objectForUserDefaults:APP_USER_TITLE_URL]:@"" ;
    DDDLog(@"defineUrlTitle====%@",defineUrl);
    return defineUrl;
}

//图片资源地址
-(NSString*)imageBaseURL:(NSString*)imageURL
{

    NSString *defineUrl =[self objectForUserDefaults:APP_IMAGE_BASE_URL]?[self objectForUserDefaults:APP_IMAGE_BASE_URL]:@"" ;
    DDDLog(@"imageBaseURL====%@",defineUrl);
    NSString* baseImageUrl =[NSString stringWithFormat:@"%@%@",defineUrl,imageURL];
    return  baseImageUrl;

}

#pragma mark-当前位置



@end
