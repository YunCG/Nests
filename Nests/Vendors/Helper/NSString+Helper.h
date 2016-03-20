//
//  NSString+Helper.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Helper)
#pragma mark- 去掉特殊字符
/*************************去掉特殊字符******************************************/
//去掉空格
- (NSString *)trim;
//去掉回车换行和空格
- (NSString *)trimSpaceAndNewline;
//去掉换行符
- (NSString *)trimNewline;
#pragma mark- 计算字符串
/*************************计算字符串******************************************/
//计算字符串高度
-(float)calculateStringHeight:(float)width
                         font:(UIFont *)font;
//计算字符串宽度
-(float)calculateStringWidth:(float)height
                        font:(UIFont *)font;
//计算字符尺寸
- (CGSize)boundingRectWithSize:(CGSize)size fontSize:(NSInteger)font;
#pragma mark-时间格式转换
/*************************时间格式转换******************************************/
//时间格式转换
-(NSString*)convertTimeFormatter:(NSString *)formatter toFormatter:(NSString *)toFormatter;
//NSString转换成NSDate
- (NSDate *)convertStringToDate:(NSString*)dateFormat;//dateString格式（yyyy-MM-dd HH:mm:ss）

#pragma mark-字符处理
/*************************字符处理******************************************/
//提取数字
- (NSString *)stringNumber;
//*符串替换(e.g电话号码*替换)
-(NSString*)startString:(int)startNum//开始替换位置
                 strLen:(int)strLen//替换长度
              character:(NSString*)character;//替换字符（e.g*）

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile;
/*车牌号验证 MODIFIED BY HELENSONG*/
-(BOOL)validateCarNo;
#pragma mark-MD5加密
/*************************MD5加密******************************************/
- (NSString *) stringMD5;
#pragma mark-JSON
-(id)stringJsonValue;


@end
