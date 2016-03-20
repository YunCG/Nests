//
//  NestsSQLite.h
//  Nests
//
//  Created by 🐠 on 9/13/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>
#define  SharedNestsSQLite  [NestsSQLite sharedInstance]
@interface NestsSQLite : NSObject
+ (id)sharedInstance;
#pragma mark-CreateSQLite
//创建SQLite
-(void)createSQLite;
-(BOOL)isExistTable:(NSString*)tableName;
//删除
-(void)cleanTable:(NSString*)tableName
          success:(void (^)(NSString *msg))success
          failure:(void (^)(NSString *msg))failure;
#pragma mark-RemoteNotification//远程通知
//查询消息
-(NSArray*)queryRemoteMessages;
//插入消息
-(void)saveRemoteMessage:(NSString*)notificationMessage
                  isRead:(BOOL)isRead;
//更具ID删除指定的行
-(void)deleteRemoteMessage:(NSString*)messageID;
//删除所有消息
-(void)deleteAllRemoteMessage;
//设置消息已读
-(void)readRemoteMessage:(NSString*)messageID
                  isRead:(BOOL)isRead;


#pragma mark-地址数据库
//查询城市
-(NSArray*)queryCity;
//查询城区
-(NSArray*)queryDistrict:(NSString*)provinceID;
//查询街道
//查询街道
-(NSArray*)queryStreet:(NSString*)areaID
            provinceID:(NSString*)provinceID;
@end
