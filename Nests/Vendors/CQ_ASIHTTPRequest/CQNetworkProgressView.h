//
//  CQNetworkProgressView.h
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
//下载进度条
@protocol DownLoadProgressViewDelegate <NSObject>
@optional
-(void) didReceiveBytesForPercent:(ASIHTTPRequest *)request percent:(float)percent;
-(void) didReceiveWithPercent:(float)percent  userInfo:(NSDictionary*)userInfo;
@end

//上传进度条
@protocol UpLoadProgressViewDelegate <NSObject>
@optional
-(void) didSendBytesForPercent:(ASIHTTPRequest *)request percent:(float)percent;
-(void) didSendWithPercent:(float)percent  userInfo:(NSDictionary*)userInfo;
@end

@interface CQNetworkProgressView : UIProgressView
//delegate
@property(nonatomic ,assign) id  delegate;

@end
