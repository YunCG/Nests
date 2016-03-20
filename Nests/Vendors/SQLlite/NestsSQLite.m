//
//  NestsSQLite.m
//  Nests
//
//  Created by 🐠 on 9/13/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsSQLite.h"
#import "FMDatabase.h"
#import "NestsKit.h"


@implementation NestsSQLite
+ (id)sharedInstance
{
    // 1
    static NestsSQLite *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NestsSQLite alloc] init];
    });
    return _sharedInstance;
}

#pragma mark-Operation

-(void)sqlExecute:(NSString*)sqlStr
           dbPath:(NSString*)dbPath
          success:(void (^)(int statusCode, NSString *msg, FMResultSet* resultSet))success
          failure:(void (^)(int statusCode, NSString *msg))failure
{
    
    DDDebug(@"sql语句》》》》》》》》》》》》》》》》:%@",sqlStr);
    //获取数据库并打开
    //    NSString* destinationPath =[SkeletonKit sandBoxLibCachePath];
    //    NSString* destinationFile =[NSString stringWithFormat:@"%@/%@",destinationPath,APP_SERVER_DB];
    
    
    FMDatabase *database  = [FMDatabase databaseWithPath:dbPath];
    [database setShouldCacheStatements:YES];
    if (![database open]) {
        NSLog(@"Open database failed");
        failure(1000,@"打开数据库失败");
        return;
    }
    
    FMResultSet *resultSet = [database executeQuery:sqlStr];
    success(9999,@"打开数据库成功",resultSet);
    //        while ([resultSet next]) {
    ////            AccompanyType *accType = [[AccompanyType alloc] autorelease];
    ////            accType.accompanyTypeID = [resultSet stringForColumn:@"id"];
    ////            accType.staticValue = [resultSet stringForColumn:@"staticValue"];
    ////            accType.staticValueDesc = [resultSet stringForColumn:@"staticValueDesc"];
    ////            accType.parentid = [resultSet stringForColumn:@"parentid"];
    ////            accType.type  = [resultSet stringForColumn:@"type"];
    ////            accType.createdate  = [resultSet stringForColumn:@"createdate"];
    ////
    ////            [self.accompanyTypeArray  addObject:accType];
    //        }
    [database close];
    
}

#pragma mark-CreateSQLite
-(void)createSQLite
{
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库创建失败");
    }
    else
    {
        
        BOOL isExistMessageTable =[self isExistTable:APP_SQLLITE_MESSAGE_TABLE];
        DDDLog(@"数据库创建成功==是否存在push表:%i",isExistMessageTable);
        
        
       if (!isExistMessageTable) {//推送NestsMessageTable表是否创建
            NSString *sql = @"create table NestsMessageTable (id integer primary key autoincrement, messages text,isRead text,createdTime TimeStamp NOT NULL DEFAULT(datetime('now','localtime')));";
            BOOL tabSuc = [db executeStatements:sql];
            if (tabSuc) {
                DDDLog(@"pushTable创建成功");
            }
            else
            {
                DDDLog(@"pushTable创建失败");
            }

       }
        
    }
    [db close];
    
}


//判断表是否存在
-(BOOL)isExistTable:(NSString*)tableName
{
    BOOL  isExist =NO;
    NSString* sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM sqlite_master where type='table' and name='%@';",tableName];
    
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
        
    }
    else
    {
        
        
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet) {
            int count = 0;
            while ([resultSet next]) {
                count =[resultSet  intForColumnIndex:0];
            }
            
            if (count>0) {
                isExist =YES;
            }
            else
            {
               isExist =NO;
            }
        }
        else
        {
            DDDLog(@"查询isExistTable创建失败");
        }
        
    }
    [db close];
    
    return isExist;
}

//清空表
-(void)cleanTable:(NSString*)tableName
          success:(void (^)(NSString *msg))success
          failure:(void (^)(NSString *msg))failure
{
    NSString* sql = [NSString stringWithFormat:@"delete from %@;",tableName];
    
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
        
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        
        BOOL tabSuc = [db executeStatements:sql];
        if (tabSuc) {
            DDDLog(@"删除pushTable创建成功");
            success(@"消息删除成功！");
        }
        else
        {
            DDDLog(@"删除pushTable创建失败");
            success(@"消息删除失败！");
        }
        
    }
    [db close];
    
    
    
}
#pragma mark-地址数据库
//查询城市
-(NSArray*)queryCity
{
    NSString* sql =  @"SELECT DISTINCT provinceId,provinceCode,provinceName from tb_street";
    NSMutableArray* messagesArray =[[NSMutableArray alloc] initWithCapacity:1];
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SERVER_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet) {
            while ([resultSet next]) {
                NSMutableDictionary* infoDic =[[NSMutableDictionary alloc] initWithCapacity:1];
                NSString* provinceId =[resultSet stringForColumn:@"provinceId"];
                NSString* provinceCode =[resultSet stringForColumn:@"provinceCode"];
                NSString* provinceName =[resultSet stringForColumn:@"provinceName"];
              \
               
                [infoDic  saveValueNotNil:provinceId forKey:@"provinceId"];
                [infoDic  saveValueNotNil:provinceCode forKey:@"provinceCode"];
                [infoDic  saveValueNotNil:provinceName forKey:@"provinceName"];
            
                [messagesArray addObject:infoDic];
            }
        }
        else
        {
            DDDLog(@"查询tb_street创建失败");
        }
        
    }
    
    [db close];
    
    
    return messagesArray;
}


//查询城区
-(NSArray*)queryDistrict:(NSString*)provinceID
{
    NSString* sql =  [NSString stringWithFormat:@"SELECT DISTINCT areaId,areaName from tb_street WHERE provinceId ='%@'",provinceID];
    NSMutableArray* messagesArray =[[NSMutableArray alloc] initWithCapacity:1];
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SERVER_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        DDDLog(@"数据库打开成功");

        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet) {
            
            
            while ([resultSet next]) {
                NSMutableDictionary* infoDic =[[NSMutableDictionary alloc] initWithCapacity:1];
                NSString* areaId =[resultSet stringForColumn:@"areaId"];
                 NSString* areaName =[resultSet stringForColumn:@"areaName"];
              
                [infoDic  saveValueNotNil:areaId forKey:@"areaId"];
                [infoDic  saveValueNotNil:areaName forKey:@"areaName"];
             
                
                [messagesArray addObject:infoDic];
            }
        }
        else
        {
            DDDLog(@"查询tb_street创建失败");
        }
        
    }
    
    [db close];
    
    
    return messagesArray;
}

//查询街道
-(NSArray*)queryStreet:(NSString*)areaID
            provinceID:(NSString*)provinceID
{
    NSString* sql =  [NSString stringWithFormat:@"SELECT DISTINCT streetId,streetName from tb_street WHERE areaId ='%@' and provinceId='%@'",areaID,provinceID];
    NSMutableArray* messagesArray =[[NSMutableArray alloc] initWithCapacity:1];
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SERVER_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        DDDLog(@"数据库打开成功");
        
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet) {
            
            
            while ([resultSet next]) {
                NSMutableDictionary* infoDic =[[NSMutableDictionary alloc] initWithCapacity:1];
                NSString* streetId =[resultSet stringForColumn:@"streetId"];
                 NSString* streetName =[resultSet stringForColumn:@"streetName"];
               
                
                [infoDic  saveValueNotNil:streetId forKey:@"streetId"];
                [infoDic  saveValueNotNil:streetName forKey:@"streetName"];
                
                
                
                
                [messagesArray addObject:infoDic];
            }
        }
        else
        {
            DDDLog(@"查询tb_street创建失败");
        }
        
    }
    
    [db close];
    
    
    return messagesArray;
}

#pragma mark-RemoteNotification//远程通知
-(NSArray*)queryRemoteMessages
{
    NSString* sql =  @"select * from NestsMessageTable  order by createdTime desc";
    NSMutableArray* messagesArray =[[NSMutableArray alloc] initWithCapacity:1];
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        
        FMResultSet *resultSet = [db executeQuery:sql];
        if (resultSet) {
            
           
            while ([resultSet next]) {
                 NSMutableDictionary* infoDic =[[NSMutableDictionary alloc] initWithCapacity:1];
                NSString* messages =[resultSet stringForColumn:@"messages"];
                NSString* isRead =[resultSet stringForColumn:@"isRead"]?[resultSet stringForColumn:@"isRead"]:@"NO";
                 NSString* createdTime =[resultSet stringForColumn:@"createdTime"];
                NSString* messageID =[NSString stringWithFormat:@"%@",[resultSet stringForColumn:@"id"]];
                [infoDic  saveValueNotNil:messages forKey:@"messages"];
                 [infoDic  saveValueNotNil:isRead forKey:@"isRead"];
                [infoDic  saveValueNotNil:createdTime forKey:@"createdTime"];
                 [infoDic  saveValueNotNil:messageID forKey:@"id"];
                
             
                
                
                [messagesArray addObject:infoDic];
            }
        }
        else
        {
            DDDLog(@"查询pushTable创建失败");
        }
        
    }
    
    [db close];
    
    
    return messagesArray;
}
-(void)saveRemoteMessage:(NSString*)notificationMessage
                  isRead:(BOOL)isRead
{
    NSString* isReadStr =@"NO";
    if (isRead) {
        isReadStr =@"YES";
    }
    
    NSString* sql = [NSString stringWithFormat:@"INSERT INTO NestsMessageTable(messages,isRead) VALUES('%@','%@');",notificationMessage,isReadStr];
    
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        BOOL tabSuc = [db executeStatements:sql];
        if (tabSuc) {
            DDDLog(@"插入pushTable创建成功");
        }
        else
        {
            DDDLog(@"插入pushTable创建失败");
        }
        
    }
    [db close];
    
    
}

//更具ID删除指定的行
-(void)deleteRemoteMessage:(NSString*)messageID
{
    
    
    NSString* sql = [NSString stringWithFormat:@"delete from NestsMessageTable where id ='%@'",messageID];
    
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        BOOL tabSuc = [db executeStatements:sql];
        if (tabSuc) {
            DDDLog(@"删除readRemoteMessage===row:%@创建成功",messageID);
        }
        else
        {
            DDDLog(@"删除readRemoteMessage===row:%@创建失败",messageID);
        }
        
    }
    [db close];
    
    
}

//删除所有消息
-(void)deleteAllRemoteMessage
{

    NSString* sql = [NSString stringWithFormat:@"delete from NestsMessageTable"];
    
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        BOOL tabSuc = [db executeStatements:sql];
        if (tabSuc) {
            DDDLog(@"删除readRemoteMessage成功");
        }
        else
        {
            DDDLog(@"删除readRemoteMessage创建失败");
        }
        
    }
    [db close];
    
    
}

//设置消息已读
-(void)readRemoteMessage:(NSString*)messageID
                  isRead:(BOOL)isRead
{
    NSString* isReadStr =@"NO";
    if (isRead) {
        isReadStr =@"YES";
    }
    
    NSString* sql = [NSString stringWithFormat:@"update NestsMessageTable set isRead='%@' where id ='%@'",isReadStr,messageID];
    
    NSString* dbPath =[[NestsKit sandBoxLibCachePath] stringByAppendingFormat:@"/%@",APP_SQLLITE_DB];
    DDDLog(@"PUSH_SQLite path :%@",dbPath);
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        DDDLog(@"数据库打开失败");
    }
    else
    {
        
        DDDLog(@"数据库打开成功");
        
        
        BOOL tabSuc = [db executeStatements:sql];
        if (tabSuc) {
            DDDLog(@"插入readRemoteMessage创建成功");
        }
        else
        {
            DDDLog(@"插入readRemoteMessage创建失败");
        }
        
    }
    [db close];
    
    
}

@end
