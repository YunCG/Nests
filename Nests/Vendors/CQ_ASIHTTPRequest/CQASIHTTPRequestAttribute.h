//
//  CQASIHTTPRequestAttribute.h
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASICacheDelegate.h"
#import "CQNetworkConfigs.h"
@interface CQASIHTTPRequestAttribute : NSObject
@property(nonatomic,assign) int networkRequestTypeID;//网络请求标识

@property (assign) SEL requestDidFinishSelector;//请求成功后调用方法（必须）
@property (assign) SEL requestDidFailSelector;//请求失败后调用方法（必须）

@property(nonatomic,copy)     NSString* diskCachePath;//缓存文件路径
@property(nonatomic,assign)  ASICachePolicy cachePolicy;//缓存缓存策略

@property(nonatomic,assign)  BOOL   isAllowResume;//是否允许断点续传（默认允许）
@property(nonatomic,assign)  BOOL   isBackDownLoad;//是否允许后台下载（默认允许）

@property(nonatomic,copy) NSString* destinationFile;//下载目标文件
@property(nonatomic,copy) NSString* temporaryFile;//下载零时文件

@property(nonatomic,retain)UIProgressView* downLoadProgressView;//下载进度条
@property(nonatomic,retain)UIProgressView* upLoadProgressView;//上传进度条
@property(nonatomic,assign)  BOOL   isShowAccurateProgress;//是否显示精准进度条（默认为NO）

@property(nonatomic,assign)  BOOL   isSynchronous;//是否为同步请求

@property(nonatomic,assign) NSStringEncoding responseEncoding;//设置请求编码（默认为UTF-8）

@property(nonatomic,assign) NSString*  contentType;//Content-Type

@end
