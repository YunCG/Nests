//
//  NestsKit.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NestsKit : NSObject
#pragma mark-网络
#pragma mark-App信息
//获得应用版本号(发布版本号:CFBundleShortVersionString)
+(NSString*)appVersion;
//获得应用版本号(内部版本号:CFBundleVersion)
+(NSString*)appBuildVersion;
//获得App名字
+(NSString*)appName;
#pragma mark-拨打电话
+(void)callPhone:(NSString*)phoneNum;
#pragma mark-App启动信息
+(BOOL)isAppFirstLanch;
+(void)saveAppFirstLanch:(BOOL)isFirst;
#pragma mark-设备信息
//设备唯一表述
+(NSString*)deviceIdentifier;
#pragma mark-network
//判断网络是否可用
+ (BOOL) isNetworkValid;
#pragma mark-本地目录管理
// 程序主目录，可见子目录(3个):Documents、Library、tmp
+ (NSString *)sandBoxHomePath;
// 程序目录，不能存任何东西
+ (NSString *)sandBoxAppPath;
// 文档目录，需要ITUNES同步备份的数据存这里，可存放用户数据
+ (NSString *)sandBoxDocPath;
// 配置目录，配置文件存这里
+ (NSString *)sandBoxLibPrefPath;
// 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)sandBoxLibCachePath;
// 临时缓存目录，APP退出后，系统可能会删除这里的内容
+ (NSString *)sandBoxTempPath;
//判断目录是否存在，不存在则创建
+ (BOOL)sandBoxFileIsLive:(NSString *)path;
//判断文件是否存在
+ (BOOL) isFileExist:(NSString *)filePath;
@end
