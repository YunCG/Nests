//
//  CQNetworkProgressView.m
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "CQNetworkProgressView.h"

@implementation CQNetworkProgressView
@synthesize delegate=_delegate;
- (void)dealloc
{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate =nil;
    }
    return self;
}



#pragma mark-
#pragma mark 下载进度delegate
- (void)request:(ASIHTTPRequest *)request didReceiveBytes:(long long)bytes
{
    NSLog(@"已下载%f===是否完成=%i",self.progress*100,request.complete);
    float percent =self.progress*100;
    NSDictionary   *asiUserInfo = request.userInfo;
    NSDictionary   *userInfo =[asiUserInfo objectForKey:@"CLM_USERINFO"];
    
    
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(didReceiveWithPercent:userInfo:)])
    {
        
        //        [self.delegate didReceiveBytesForPercent:(ASIHTTPRequest *)request percent:self.progress*100];
        [self.delegate didReceiveWithPercent:percent userInfo:userInfo];
    }
}

#pragma mark-
#pragma mark 上传进度
- (void)request:(ASIHTTPRequest *)request didSendBytes:(long long)bytes
{
    
    NSLog(@"已发送数据了===%f==是否完成==%i",self.progress*100,request.complete);
    float percent =self.progress*100;
    NSDictionary   *asiUserInfo = request.userInfo;
    NSDictionary   *userInfo =[asiUserInfo objectForKey:@"CLM_USERINFO"];
    if (self.delegate!=nil&&[self.delegate respondsToSelector:@selector(didSendWithPercent:userInfo:)])
    {
        
        //        [self.delegate didReceiveBytesForPercent:(ASIHTTPRequest *)request percent:self.progress*100];
        [self.delegate didSendWithPercent:percent userInfo:userInfo];
    }
}



@end
