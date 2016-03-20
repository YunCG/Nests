//
//  CQASIHttpClient.h
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CQAnalyticDataInfo.h"
#import "CQNetworkConfigs.h"
#import "CQNetworkProgressView.h"
@interface CQASIHttpClient : NSObject
//Get
- (void)requestFromGet:(NSURL*)requestURL  //URL(必须)
      netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
               isCache:(BOOL)isCache //是否缓存
        diskCachePath :(NSString*)diskCachePath //缓存路径（可以为nil）
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo;

- (void)requestFromMode:(NSURL*)requestURL  //URL(必须)
       netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
                 method:(NSString*)method
                 reqStr:(NSString*)reqStr
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo;


- (void)requestWithModeSupplement:(NSURL*)requestURL  //URL(必须)
                      requestType:(int)requestType //RequesTypeID(必须)
                      contentType:(NSString*)contentType
                           method:(NSString*)method
                           reqStr:(NSString*)reqStr
                         delegate:(id)delegate
                        didFinish:(SEL)didFinish
                        didFailed:(SEL)didFailed
                         userInfo:(NSDictionary*)userInfo;

//POST
- (void)requestFromPost:(NSURL*)requestURL  //URL(必须)
       netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
      dictionaryForText:(NSMutableDictionary*)dictionaryForText
keyForFile:(NSMutableDictionary*)keyForFile
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo;

//DownLoadFile
- (void)startDownloadFile:(NSURL*)requestURL
         netWorkRequestID:(int)netWorkRequestID
          destinationFile:(NSString*)destinationFile
            temporaryFile:(NSString*)temporaryFile
             progressView:(CQNetworkProgressView *)progressView
                 delegate:(id)delegate
                didFinish:(SEL)didFinish
                didFailed:(SEL)didFailed
                 userInfo:(NSDictionary*)userInfo;





@end
