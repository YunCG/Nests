//
//  CQASIHTTPRequestAttribute.m
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "CQASIHTTPRequestAttribute.h"

@implementation CQASIHTTPRequestAttribute
- (void)dealloc
{
    [super dealloc];
}
- (id)init
{
    self = [super init];
    if (self) {
        
        //设置默认值
        self.cachePolicy = ASIUseDefaultCachePolicy;
        self.isAllowResume =YES;
        self.isBackDownLoad =YES;
        //下载目录
        self.destinationFile =nil;
        self.temporaryFile   =nil;
        //上传下载精度条
        self.downLoadProgressView =nil;
        self.upLoadProgressView   =nil;
        self.isShowAccurateProgress =NO;
        
        //是否为同步请求
        self.isSynchronous =NO;//默认为异步
        
        self.responseEncoding =NSUTF8StringEncoding;
        self.contentType =@"text/xml";
        
    }
    return self;
}

@end
