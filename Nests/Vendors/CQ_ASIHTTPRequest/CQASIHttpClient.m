//
//  CQASIHttpClient.m
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "CQASIHttpClient.h"
#import "CQASIHTTPRequestHTTPClient.h"
#import "CQNetworkProgressView.h"



#define   USER_DELEGATE              @"USER_DELEGATE"   //用户delegate     (不能为nil)
#define   USER_DIDFINISH             @"USER_DIDFINISH"  //用户定义回调成功方法(不能为nil)
#define   USER_DIDFAILED             @"USER_DIDFAILED"  //用户定义回调失败方法(不能为nil)
#define   USER_USERINFO              @"USER_USERINFO"   //用户定义UserInfo(需要放在最后可以为nil)
//#define   USER_ANALYTIC_DATA              @"USER_ANALYTIC_DATA"   //用户定义解析方法(不能为nil)

#define   USER_DESTINATIONFILE       @"USER_DESTINATIONFILE"   //文件下载成功后的目标文件
#define   USER_TEMPORARYFILE         @"USER_TEMPORARYFILE"    //零时文件
@implementation CQASIHttpClient
#pragma mark-
#pragma mark Request GET
- (void) requestWithGET:(NSURL*)requestURL  //URL(必须)
            requestType:(int)requestType //RequesTypeID(必须)
         diskCachePath :(NSString*)diskCachePath //缓存路径（可以为nil）
            cachePolicy:(ASICachePolicy)cachePolicy//存储策（可以为nil）
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{
    
    
    
    NSLog(@"didFinish方法===%@", NSStringFromSelector(didFinish));
    
    //ASIHTTP配置
    CQASIHTTPRequestAttribute* requestAttribute =[[[CQASIHTTPRequestAttribute alloc] init] autorelease];
    [requestAttribute  setNetworkRequestTypeID:requestType];//请求requestTypeID
    [requestAttribute  setCachePolicy:cachePolicy];
    [requestAttribute  setDiskCachePath:diskCachePath];
    [requestAttribute  setRequestDidFinishSelector:@selector(didRequestFinished:)];
    [requestAttribute  setRequestDidFailSelector:@selector(didRequestFailed:)];
    
    //ASIHTTPUserInfo
    NSDictionary* asiUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 delegate,   USER_DELEGATE,
                                 NSStringFromSelector(didFinish),  USER_DIDFINISH,
                                 NSStringFromSelector(didFailed),  USER_DIDFAILED,
                                 userInfo,USER_USERINFO,
                                 nil];
    
    CQASIHTTPRequestHTTPClient*  networkRequest =[CQASIHTTPRequestHTTPClient initWithDelegate:self];
    [networkRequest requestWithASIHTTPRequest:requestURL requestAttribute:requestAttribute userInfo:asiUserInfo];
    
    
    
}



- (void)requestWithMode:(NSURL*)requestURL  //URL(必须)
            requestType:(int)requestType //RequesTypeID(必须)
                 method:(NSString*)method
                 reqStr:(NSString*)reqStr
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{

    NSLog(@"didFinish方法===%@", NSStringFromSelector(didFinish));
    
    //ASIHTTP配置
    CQASIHTTPRequestAttribute* requestAttribute =[[[CQASIHTTPRequestAttribute alloc] init] autorelease];
    [requestAttribute  setNetworkRequestTypeID:requestType];//请求requestTypeID
    [requestAttribute  setRequestDidFinishSelector:@selector(didRequestFinished:)];
    [requestAttribute  setRequestDidFailSelector:@selector(didRequestFailed:)];
    [requestAttribute setContentType:@"application/json"];
    
    //ASIHTTPUserInfo
    NSDictionary* asiUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 delegate,   USER_DELEGATE,
                                 NSStringFromSelector(didFinish),  USER_DIDFINISH,
                                 NSStringFromSelector(didFailed),  USER_DIDFAILED,
                                 userInfo,USER_USERINFO,
                                 nil];
    
    CQASIHTTPRequestHTTPClient*  networkRequest =[CQASIHTTPRequestHTTPClient initWithDelegate:self];
    [networkRequest  requestWithMode:requestURL reqStr:reqStr method:method requestAttribute:requestAttribute userInfo:asiUserInfo];

}



- (void)requestWithModeSupplement:(NSURL*)requestURL  //URL(必须)
            requestType:(int)requestType //RequesTypeID(必须)
                      contentType:(NSString*)contentType
                 method:(NSString*)method
                 reqStr:(NSString*)reqStr
               delegate:(id)delegate
              didFinish:(SEL)didFinish
              didFailed:(SEL)didFailed
               userInfo:(NSDictionary*)userInfo
{
    
    NSLog(@"didFinish方法===%@", NSStringFromSelector(didFinish));
    
    //ASIHTTP配置
    CQASIHTTPRequestAttribute* requestAttribute =[[[CQASIHTTPRequestAttribute alloc] init] autorelease];
    [requestAttribute setContentType:contentType];
    [requestAttribute  setNetworkRequestTypeID:requestType];//请求requestTypeID
    [requestAttribute  setRequestDidFinishSelector:@selector(didRequestFinished:)];
    [requestAttribute  setRequestDidFailSelector:@selector(didRequestFailed:)];
    
    //ASIHTTPUserInfo
    NSDictionary* asiUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 delegate,   USER_DELEGATE,
                                 NSStringFromSelector(didFinish),  USER_DIDFINISH,
                                 NSStringFromSelector(didFailed),  USER_DIDFAILED,
                                 userInfo,USER_USERINFO,
                                 nil];
    
    CQASIHTTPRequestHTTPClient*  networkRequest =[CQASIHTTPRequestHTTPClient initWithDelegate:self];
    [networkRequest  requestWithMode:requestURL reqStr:reqStr method:method requestAttribute:requestAttribute userInfo:asiUserInfo];
    
}


#pragma mark-
#pragma mark Request POST


- (void) requestWithPost:(NSURL*)requestURL
             requestType:(int)requestType
              keyForText:(NSMutableDictionary*)keyForText
              keyForFile:(NSMutableDictionary*)keyForFile
            progressView:(CQNetworkProgressView *)progressView
                delegate:(id)delegate
               didFinish:(SEL)didFinish
               didFailed:(SEL)didFailed
                userInfo:(NSDictionary*)userInfo
{
    
    //ASIHTTP配置
    CQASIHTTPRequestAttribute* requestAttribute =[[[CQASIHTTPRequestAttribute alloc] init] autorelease];
    [requestAttribute  setNetworkRequestTypeID:requestType];//请求requestTypeID
    [requestAttribute  setRequestDidFinishSelector:@selector(didRequestFinished:)];
    [requestAttribute  setRequestDidFailSelector:@selector(didRequestFailed:)];
    
    //进度条
    if (progressView) {
        [requestAttribute setIsShowAccurateProgress:YES];
        [requestAttribute setUpLoadProgressView:progressView];//上传进度条设置
    }
    
    
    
    //ASIHTTPUserInfo
    NSDictionary* asiUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 delegate,   USER_DELEGATE,
                                 NSStringFromSelector(didFinish),  USER_DIDFINISH,
                                 NSStringFromSelector(didFailed),  USER_DIDFAILED,
                                 userInfo,USER_USERINFO,
                                 nil];
    
    
    CQASIHTTPRequestHTTPClient*  networkRequest =[CQASIHTTPRequestHTTPClient initWithDelegate:self];
    [networkRequest sendDataWithASIFormDataRequest:requestURL requestAttribute:requestAttribute keyForText:keyForText keyForFile:keyForFile userInfo:asiUserInfo];
    
}


#pragma mark-
#pragma mark downLoad File
- (void)startDownloadFile:(NSURL*)requestURL
              requestType:(int)requestType
          destinationFile:(NSString*)destinationFile
            temporaryFile:(NSString*)temporaryFile
             progressView:(CQNetworkProgressView *)progressView
                 delegate:(id)delegate
                didFinish:(SEL)didFinish
                didFailed:(SEL)didFailed
                 userInfo:(NSDictionary*)userInfo
{
    
    //        NSLog(@"打印下载文件===%@==temp===%@",destinationFile,temporaryFile);
    
    //ASIHTTP配置
    CQASIHTTPRequestAttribute* requestAttribute =[[[CQASIHTTPRequestAttribute alloc] init] autorelease];
    
    [requestAttribute  setNetworkRequestTypeID:requestType];//请求requestTypeID
    [requestAttribute setDestinationFile:destinationFile];
    [requestAttribute  setTemporaryFile:temporaryFile];
    
    [requestAttribute setRequestDidFinishSelector:@selector(didRequestFinished:)];
    [requestAttribute  setRequestDidFailSelector:@selector(didRequestFailed:)];
    //是否支持断点续传
    [requestAttribute  setIsAllowResume:YES];
    [requestAttribute  setIsBackDownLoad:YES];
    //进度条
    //下载进度条
    if (progressView) {
        [requestAttribute setIsShowAccurateProgress:YES];
        [requestAttribute setDownLoadProgressView:progressView];//下载进度条设置
    }
    
    
    //ASIHTTPUserInfo
    NSDictionary* asiUserInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                 destinationFile,USER_DESTINATIONFILE,//文件下载成功的目标文件
                                 temporaryFile,USER_TEMPORARYFILE, //临时文件
                                 delegate,   USER_DELEGATE,
                                 NSStringFromSelector(didFinish),  USER_DIDFINISH,
                                 NSStringFromSelector(didFailed),  USER_DIDFAILED,
                                 userInfo,USER_USERINFO,
                                 nil];
    
    
    CQASIHTTPRequestHTTPClient*  networkRequest =[CQASIHTTPRequestHTTPClient initWithDelegate:self];
    //开始下载
    [networkRequest downLoadFileWithASIHTTPRequest:requestURL requestAttribute:requestAttribute userInfo:asiUserInfo];
    
}


#pragma mark-
#pragma mark request Delegate
//request success
- (void) didRequestFinished:(ASIHTTPRequest *)request
{
    int statusCode = [request responseStatusCode];
    NSString *statusMessage = [request responseStatusMessage];
    NSLog(@"打印HTTP状态码%i  statusMessage==%@",statusCode,statusMessage);
    
        NSDictionary   *asiUserInfo = request.userInfo;
        int    requestTypeID =request.tag;
        NSData*     responeData =[request responseData];
        NSLog(@"信息请求成功～～～～～～～～%i",requestTypeID);
        //用户配置
        id  delegate =[asiUserInfo objectForKey:USER_DELEGATE];
        NSString*   didFinishStr =(NSString*)[asiUserInfo objectForKey:USER_DIDFINISH];
        SEL         didFinish =NSSelectorFromString(didFinishStr);
        NSString*   didFailedStr =(NSString*)[asiUserInfo objectForKey:USER_DIDFAILED];
        SEL         didFailed =NSSelectorFromString(didFailedStr);//失败
        NSDictionary   *userInfo =[asiUserInfo objectForKey:USER_USERINFO];
        //    NSLog(@"打印http请求码＝＝%i",request.code);
        NSLog(@"didFinishStr===%@\ndidFailedStr=%@=",didFinishStr,didFailedStr);
        NSLog(@"返回得解析字符串为:%@",request.responseString);
        NSString*  responseStr = request.responseString;
    if (statusCode == 200) {
        if (delegate&&[delegate respondsToSelector:didFinish])
        {
            [delegate performSelector:didFinish withObject:responseStr withObject:userInfo];
        }
        else
        {
            NSLog(@"无效ASIHTTPCLIENT delegate==%@",delegate);
        
        }
        
        

    }
    else
    {
        
        [self didRequestFailed:request];
    
    }
   //
//   BOOL isSuccess  =[SharedAnalyticDataInfo serverResult:responeData];
//     if (isSuccess) {
//         NSLog(@"信息对应解析方法:%@",analyticDataStr);
//         id  result= [SharedAnalyticDataInfo performSelector:analyticData withObject:responeData];
//     if (delegate&&[delegate respondsToSelector:didFinish])
//    {
//        [delegate performSelector:didFinish withObject:result withObject:userInfo];
//    }
//   }
//   else
//  {
//       if (delegate&&[delegate respondsToSelector:didFailed])
//       {
//           NSString*  message= [SharedAnalyticDataInfo serverResultMessage:responeData];
//            if (!message) {
//                message =@"服务器无错误消息返回";
//            }
//
//            NSError* error =[NSError errorWithDomain:message code:1111 userInfo:userInfo];
//            [delegate performSelector:didFailed withObject:error withObject:userInfo];
//         }
//
//   }
//    
    
}


- (void) didRequestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"服务器返回失败:%@",error);
    NSDictionary   *asiUserInfo = request.userInfo;
    //用户配置
    id  delegate =[asiUserInfo objectForKey:USER_DELEGATE];
    NSString*   didFailedStr =(NSString*)[asiUserInfo objectForKey:USER_DIDFAILED];
    SEL         didFailed =NSSelectorFromString(didFailedStr);//失败
    NSDictionary   *userInfo =[asiUserInfo objectForKey:USER_USERINFO];
    
    if (delegate&&[delegate respondsToSelector:didFailed])
    {
        [delegate performSelector:didFailed withObject:error withObject:userInfo];
    }
}

///////////////////////////////////////////////////////////////////////////
#pragma mark 公共接口
- (void)requestFromGet:(NSURL*)requestURL  //URL(必须)
      netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
               isCache:(BOOL)isCache //是否缓存
        diskCachePath :(NSString*)diskCachePath //缓存路径（可以为nil）
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo
{
    ASICachePolicy cachePolicy =ASIUseDefaultCachePolicy;
    
    if (isCache) {
        cachePolicy =ASIFallbackToCacheIfLoadFailsCachePolicy;
    }
    
    
    [self requestWithGET:requestURL
             requestType:netWorkRequestID
           diskCachePath:diskCachePath
             cachePolicy:cachePolicy
                delegate:delegate
               didFinish:didFinish
               didFailed:didFailed
                userInfo:userInfo];
}


- (void)requestFromMode:(NSURL*)requestURL  //URL(必须)
      netWorkRequestID:(int)netWorkRequestID //RequesTypeID(必须)
                method:(NSString*)method
                reqStr:(NSString*)reqStr
              delegate:(id)delegate
             didFinish:(SEL)didFinish
             didFailed:(SEL)didFailed
              userInfo:(NSDictionary*)userInfo
{
    
    
    [self requestWithMode:requestURL requestType:netWorkRequestID method:method reqStr:reqStr delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];
}


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

    [self requestWithPost:requestURL requestType:netWorkRequestID keyForText:dictionaryForText keyForFile:keyForFile progressView:nil delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];
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
    [self startDownloadFile:requestURL requestType:netWorkRequestID destinationFile:destinationFile temporaryFile:temporaryFile progressView:progressView delegate:delegate didFinish:didFinish didFailed:didFailed userInfo:userInfo];

}


@end
