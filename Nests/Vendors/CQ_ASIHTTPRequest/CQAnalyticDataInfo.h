//
//  CQAnalyticDataInfo.h
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  SharedAnalyticDataInfo  [CQAnalyticDataInfo sharedInstance]
@interface CQAnalyticDataInfo : NSObject
//init
+ (id)sharedInstance;

//判断服务器请求返回参数
-(BOOL)serverResult:(NSData *)data;
//服务器返回消息
-(NSString*)serverResultMessage:(NSData *)data;

@end
