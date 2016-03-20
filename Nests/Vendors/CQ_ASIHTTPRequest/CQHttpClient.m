//
//  CQHttpClient.m
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "CQHttpClient.h"


@interface CQHttpClient ()


@end

@implementation CQHttpClient
#pragma mark- init
- (void)dealloc
{
    
    self.httpClient =nil;
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
         self.httpClient =[[CQASIHttpClient alloc] init];
    }
    return self;
}


#pragma mark- GetHttp
- (void)requestFromGet:(NSURL*)requestURL  //URL(必须)
      netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
               isCache:(BOOL)isCache //是否缓存
        diskCachePath :(NSString*)diskCachePath //缓存路径（可以为nil）
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo
{

    
     [self.httpClient requestFromGet:requestURL netWorkRequestID:netWorkRequestID isCache:isCache diskCachePath:diskCachePath delegate:delegate didFinish:didFinish didFailed:didFailed  userInfo:userInfo];
    
    
}

- (void)requestFromMode:(NSURL*)requestURL  //URL(必须)
       netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
                 method:(NSString*)method
            reqDic:(NSDictionary*)reqDic
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{
    NSString *reqStr =@"";
    if (reqDic) {
//        reqStr = [reqDic JSONString];
        
        if ([NSJSONSerialization isValidJSONObject:reqDic])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:NSJSONWritingPrettyPrinted error:&error];
            reqStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
           NSLog(@"requestWithMode发送的字符串内容===：%@",reqStr);
        }
        else
        {
        
            NSLog(@"JSON 解析失败");
        }
        
        
//        reqStr=[MBURLHelper encryptUseDES:reqStr key:nil];
        
    }
    [self.httpClient requestFromMode:requestURL netWorkRequestID:netWorkRequestID method:method reqStr:reqStr delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];

}


- (void)requestFromModeSupplement:(NSURL*)requestURL  //URL(必须)
       netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
                      contentType:(NSString*)contentType
                 method:(NSString*)method
                 reqStr:(NSString*)reqStr
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{
    
    [self.httpClient requestWithModeSupplement:requestURL requestType:netWorkRequestID contentType:contentType method:method reqStr:reqStr delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];
    
}
#pragma mark- PostHttp
//POST
- (void)requestFromPost:(NSURL*)requestURL  //URL(必须)
       netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
      dictionaryForText:(NSMutableDictionary*)dictionaryForText
      keyForFile:(NSMutableDictionary*)keyForFile
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{
    
    [self.httpClient  requestFromPost:requestURL netWorkRequestID:netWorkRequestID dictionaryForText:dictionaryForText keyForFile:keyForFile delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];
}



//DownLoadFile
- (void)startDownloadFile:(NSURL*)requestURL
         netWorkRequestID:(int)netWorkRequestID
          destinationFile:(NSString*)destinationFile
            temporaryFile:(NSString*)temporaryFile
             progressView:(CQNetworkProgressView *)progressView
                 delegate:(id)delegate
                didFinish:(SEL)didFinish
                didFailed:(SEL)didFailed
                 userInfo:(NSDictionary*)userInfo
{

    [self.httpClient startDownloadFile:requestURL netWorkRequestID:netWorkRequestID destinationFile:destinationFile temporaryFile:temporaryFile progressView:progressView delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];
}

//-(void)didFinish:(id)result userInfo:(NSDictionary*)userInfo
//{
//    
//    
//    NSLog(@"httpNetworkTest～～～～～～成功==%@",result);
//    
//    
//}
//-(void)didFailed:(NSError *)error userInfo:(NSDictionary*)userInfo
//{
//    NSLog(@"httpNetworkTest查询失败==%@",error);
//}

@end
