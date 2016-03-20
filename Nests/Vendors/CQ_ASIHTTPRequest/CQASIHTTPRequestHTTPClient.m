//
//  CQASIHTTPRequestHTTPClient.m
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "CQASIHTTPRequestHTTPClient.h"
#import "ASIDownloadCache.h"


@implementation CQASIHTTPRequestHTTPClient
//init
- (void)dealloc
{
    [super dealloc];
}
-(id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate =delegate;
    }
    return self;
}

+(id)initWithDelegate:(id)delegate
{
    
    return [[[CQASIHTTPRequestHTTPClient  alloc] initWithDelegate:delegate] autorelease] ;
}

#pragma mark -
#pragma mark ASIHTTPRequest  GET

//ASIHTTPRequest请求数据（GET）
- (void) requestWithASIHTTPRequest:(NSURL*)requestURL
                  requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
                          userInfo:(NSDictionary*)userInfo
{
    
    
   NSLog(@"Get请求路径:%@",requestURL);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:requestAttribute.isBackDownLoad];
#endif
    //request配置cache
    ASIDownloadCache *cache =[self downLoadCache:requestAttribute.diskCachePath cachePolicy:requestAttribute.cachePolicy];
    [request setDownloadCache:cache];
    //设置request存储策略
    //缓存的相应数据会被永久存储
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    //[request setSecondsToCache:60*60*24]; // 缓存1 天
    //request设置
    request.defaultResponseEncoding = requestAttribute.responseEncoding;//设置request编码
    request.tag =requestAttribute.networkRequestTypeID;
    request.userInfo = userInfo;
    [request setDelegate:self.delegate];
    [request setDidFinishSelector:requestAttribute.requestDidFinishSelector];
    [request setDidFailSelector:requestAttribute.requestDidFailSelector];
    
    if (requestAttribute.isSynchronous)
    {
        [request startSynchronous];//发送同步请求
    }
    else
    {
        
        [request startAsynchronous];//发送异步请求
    }
    
}

//text/plain： 窗体数据以纯文本形式进行编码（UserInfo无效果）
- (void)requestWithMode:(NSURL*)requestURL
                 reqStr:(NSString*)reqStr
                 method:(NSString*)method
       requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
               userInfo:(NSDictionary*)userInfo
{
     NSLog(@"ASIHTTPRequest Post请求路径:%@",requestURL);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
    [request setRequestMethod:method];
    [request addRequestHeader:@"Content-Type" value:requestAttribute.contentType];

    [request appendPostData:[reqStr dataUsingEncoding:requestAttribute.responseEncoding]];
    //request设置
    request.defaultResponseEncoding = requestAttribute.responseEncoding;//设置request编码
    request.tag =requestAttribute.networkRequestTypeID;
    request.userInfo = userInfo;
    [request setDelegate:self.delegate];
    [request setDidFinishSelector:requestAttribute.requestDidFinishSelector];
    [request setDidFailSelector:requestAttribute.requestDidFailSelector];
    
//    [request setTimeOutSeconds:5];
    if (requestAttribute.isSynchronous)
    {
        [request startSynchronous];//发送同步请求
    }
    else
    {
        
        [request startAsynchronous];//发送异步请求
    }

    
}


#pragma mark -
#pragma mark ASIHTTPRequest  POST
//ASIHttpRequest-发送数据(post)
-(void)sendDataWithASIFormDataRequest:(NSURL*)requestURL
                     requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
                           keyForText:(NSMutableDictionary*)keyForText
                           keyForFile:(NSMutableDictionary*)keyForFile
                             userInfo:(NSDictionary*)userInfo

{
    NSLog(@"Post请求路径:%@",requestURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:requestURL];
    
    
    
    NSArray* keyArrayForText =[keyForText allKeys];
    NSArray* keyArrayForFile =[keyForFile allKeys];
    
    
    //上传数据
    for (int num=0; num<[keyArrayForText count]; num++)
    {
        NSString * keyValue =[keyArrayForText objectAtIndex:num];
        id  postForValue  =[keyForText objectForKey:keyValue];
        NSLog(@"发送数据打印key===%@====%@",keyValue,postForValue);
        [request setPostValue:postForValue forKey:keyValue];
        
    }
    
    //上传文件
    for (int num=0; num<[keyArrayForFile count]; num++)
    {
        NSString * keyValue =[keyArrayForFile objectAtIndex:num];
        id  postForValue  =[keyForFile objectForKey:keyValue];
        NSLog(@"发送文件打印key===%@=====%@",keyValue,postForValue);
        [request setFile:postForValue forKey:keyValue];
        
    }
    
    
    //上传进度追踪
    [request setUploadProgressDelegate:requestAttribute.upLoadProgressView];
    //设置显示精准进度条
    [request setShowAccurateProgress:requestAttribute.isShowAccurateProgress];
    
    //request设置
    request.defaultResponseEncoding = requestAttribute.responseEncoding;//设置request编码
    request.tag =requestAttribute.networkRequestTypeID;
    request.userInfo = userInfo;
    [request setDelegate:self.delegate];
    [request setDidFinishSelector:requestAttribute.requestDidFinishSelector];
    [request setDidFailSelector:requestAttribute.requestDidFailSelector];
    
    
    if (requestAttribute.isSynchronous)
    {
        [request startSynchronous];//发送同步请求
    }
    else
    {
        
        [request startAsynchronous];//发送异步请求
    }
    
    
    
    
}



#pragma mark -
#pragma mark ASIHTTPRequest  DownLoadFile
//文件下载
-(void)downLoadFileWithASIHTTPRequest:(NSURL*)requestURL
                     requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
                             userInfo:(NSDictionary*)userInfo

{
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:requestURL];
    NSLog(@"文件下载请求路径%@",requestURL);
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:requestAttribute.isBackDownLoad];
#endif
    
    //当request完成时，整个文件会被移动到这里
    [request setDownloadDestinationPath:requestAttribute.destinationFile];
    //这个文件已经被下载了一部分
    [request setTemporaryFileDownloadPath: requestAttribute.temporaryFile];
    [request setAllowResumeForFileDownloads:requestAttribute.isAllowResume];//断点续传
    
    //设置进度条代理
    [request setDownloadProgressDelegate:requestAttribute.downLoadProgressView];
    //设置显示精准进度条
    [request setShowAccurateProgress:requestAttribute.isShowAccurateProgress];
    
    
    //request设置
    request.tag =requestAttribute.networkRequestTypeID;
    request.userInfo = userInfo;
    [request setDelegate:self.delegate];
    [request setDidFinishSelector:requestAttribute.requestDidFinishSelector];
    [request setDidFailSelector:requestAttribute.requestDidFailSelector];
    
    
    if (requestAttribute.isSynchronous)
    {
        [request startSynchronous];//发送同步请求
    }
    else
    {
        
        [request startAsynchronous];//发送异步请求
    }
    
    
}


#pragma mark-
#pragma mark 缓存管理dowLoadCache
//downLoadCache
-(ASIDownloadCache *)downLoadCache:(NSString*)diskCachePath
                       cachePolicy:(ASICachePolicy)cachePolicy
{
    //设置缓存（ASIDownloadCache只能用于get）
    ASIDownloadCache *cache = [ASIDownloadCache sharedCache];
    [cache setStoragePath:diskCachePath];
    [cache setDefaultCachePolicy:cachePolicy];//设置cache缓存策略
    [cache setShouldRespectCacheControlHeaders:NO];//无视服务端禁止缓
    
    return cache;
    
}

#pragma mark-
@end
