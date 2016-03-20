//
//  NestsKit.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsKit.h"
#import "Reachability.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import "SvUDIDTools.h"

@implementation NestsKit
#pragma mark-App信息
//获得应用版本号(发布版本号:CFBundleShortVersionString)
+(NSString*)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appVersion= [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
    
}

//获得应用版本号(内部版本号:CFBundleVersion)
+(NSString*)appBuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appVersion= [infoDictionary objectForKey:@"CFBundleVersion"];
    return appVersion;
    
}
//获得App名字
+(NSString*)appName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* info= [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return info;
    
}
#pragma mark-App启动信息
+(BOOL)isAppFirstLanch
{
    BOOL isApFirst =YES;
    

 
        NSString *isFirstLanch =[NSString stringWithFormat:@"%@",[self objectForUserDefaults:APP_FIRST_LANCH]] ;
        if ([APP_FIRST_LANCH isEqualToString:isFirstLanch]) {
            DDDebug(@"第一次登陆。。。。%@",isFirstLanch);
            isApFirst =NO;
            
        }

   
       return isApFirst;
}

+(void)saveAppFirstLanch:(BOOL)isFirst
{
   
    if (isFirst) {
        [self saveUserDefaultsNotNil:APP_NOT_FIRST_LANCH keyValue:APP_FIRST_LANCH];
       
    }
    else
    {
          [self saveUserDefaultsNotNil:APP_FIRST_LANCH keyValue:APP_FIRST_LANCH];
    }
    
    NSString *isFirstLanch =[NSString stringWithFormat:@"%@",[self objectForUserDefaults:APP_FIRST_LANCH]] ;
    DDDebug(@"设置第一次登陆。。。。%@",isFirstLanch);
   
}

#pragma mark-拨打电话
+(void)callPhone:(NSString*)phoneNum
{
    NSLog(@"拨打电话。。。%@",phoneNum);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]];
}

#pragma mark-设备信息
//设备唯一表述
+(NSString*)deviceIdentifier
{
    NSString *identity = [SvUDIDTools UDID];
    
    return identity;
}
#pragma mark-network
//判断网络是否可用
+ (BOOL) isNetworkValid
{
    // 创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    /**
     *  SCNetworkReachabilityRef: 用来保存创建测试连接返回的引用
     *
     *  SCNetworkReachabilityCreateWithAddress: 根据传入的地址测试连接.
     *  第一个参数可以为NULL或kCFAllocatorDefault
     *  第二个参数为需要测试连接的IP地址,当为0.0.0.0时则可以查询本机的网络连接状态.
     *  同时返回一个引用必须在用完后释放.
     *  PS: SCNetworkReachabilityCreateWithName: 这个是根据传入的网址测试连接,
     *  第二个参数比如为"www.apple.com",其他和上一个一样.
     *
     *  SCNetworkReachabilityGetFlags: 这个函数用来获得测试连接的状态,
     *  第一个参数为之前建立的测试连接的引用,
     *  第二个参数用来保存获得的状态,
     *  如果能获得状态则返回TRUE，否则返回FALSE
     *
     */
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flagsn");
        return NO;
    }
    
    /**
     *  kSCNetworkReachabilityFlagsReachable: 能够连接网络
     *  kSCNetworkReachabilityFlagsConnectionRequired: 能够连接网络,但是首先得建立连接过程
     *  kSCNetworkReachabilityFlagsIsWWAN: 判断是否通过蜂窝网覆盖的连接,
     *  比如EDGE,GPRS或者目前的3G.主要是区别通过WiFi的连接.
     *
     */
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

#pragma mark- SandBox
/**********************************SandBox************************************************/
// 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)sandBoxHomePath
{
    return NSHomeDirectory();
}
// 程序目录，不能存任何东西
+ (NSString *)sandBoxAppPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
//文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)sandBoxDocPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}
//配置目录，配置文件存这里
+ (NSString *)sandBoxLibPrefPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}
// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)sandBoxLibCachePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}
// 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)sandBoxTempPath
{return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}
//判断目录是否存在，不存在则创建
+ (BOOL)sandBoxFileIsLive:(NSString *)path
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:path] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    
    return NO;
}
//判断文件是否存在
+ (BOOL) isFileExist:(NSString *)filePath
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}


@end
