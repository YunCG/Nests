//
//  CQAnalyticDataInfo.m
//  iCity_CQ
//
//  Created by Deus on 14-5-10.
//  Copyright (c) 2014年 whty. All rights reserved.
//

#import "CQAnalyticDataInfo.h"

@implementation CQAnalyticDataInfo
#pragma mark- init
- (id)init
{
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}
+ (id)sharedInstance
{
    // 1
    static CQAnalyticDataInfo *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[CQAnalyticDataInfo alloc] init];
    });
    return _sharedInstance;
}
#pragma mark -
#pragma mark analyData
-(NSDictionary*) analyticJSONData:(NSData *)data
{
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (result == nil) {
        NSString* jsonString=[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
        NSLog(@"JSON解析失败:%@",jsonString);
        NSLog(@"JSON解析失败error:%@",error);
        return nil;
    }
    
    return result;
    
}
#pragma mark-
#pragma mark 判断服务器是否请求成功
//判断服务器请求返回参数
-(BOOL)serverResult:(NSData *)data
{
    NSString*  jsonString =[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"服务器请求返回:%@",jsonString);
    NSDictionary* result  =[self analyticJSONData:data];
    
    BOOL isSuccess =NO;
    
    if (result) {
        isSuccess = [[result objectForKey:@"isSuccess"] boolValue];
    }
    
    return isSuccess;
    
}

//服务器返回消息
-(NSString*)serverResultMessage:(NSData *)data
{
    
    NSDictionary* result  =[self analyticJSONData:data];
    
    NSString* serverMessage =[result objectForKey:@"retMsg"];
    NSLog(@"服务器请求信息:%@",serverMessage);
    return serverMessage;
    
}


@end
