//
//  CQASIHTTPRequestHTTPClient.h
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "CQASIHTTPRequestAttribute.h"
@interface CQASIHTTPRequestHTTPClient : NSObject
@property(nonatomic,assign) id  delegate;
#pragma mark-方法
//init
+(id)initWithDelegate:(id)delegate;
//ASIHTTPRequest请求数据（GET）
- (void) requestWithASIHTTPRequest:(NSURL*)requestURL
                  requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
                          userInfo:(NSDictionary*)userInfo;
- (void)requestWithMode:(NSURL*)requestURL
                 reqStr:(NSString*)reqStr
                 method:(NSString*)method
       requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
               userInfo:(NSDictionary*)userInfo;

//ASIHttpRequest-发送数据(post)
-(void)sendDataWithASIFormDataRequest:(NSURL*)requestURL
                     requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
                           keyForText:(NSMutableDictionary*)keyForText
                           keyForFile:(NSMutableDictionary*)keyForFile
                             userInfo:(NSDictionary*)userInfo;
//文件下载
-(void)downLoadFileWithASIHTTPRequest:(NSURL*)requestURL
                     requestAttribute:(CQASIHTTPRequestAttribute*)requestAttribute
                             userInfo:(NSDictionary*)userInfo;

@end
