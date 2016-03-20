//
//  NSString+Helper.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Helper)
#pragma mark- 去掉特殊字符
/*************************去掉特殊字符******************************************/
//去掉空格
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
//去掉回车换行和空格
- (NSString *)trimSpaceAndNewline
{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
//去掉换行符
- (NSString *)trimNewline
{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
}

#pragma mark- 计算字符串
/*************************计算字符串******************************************/
//计算字符串高度
-(float)calculateStringHeight:(float)width
                         font:(UIFont *)font

{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 0)];
    detailTextView.font = font;
    detailTextView.text = self;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(width,CGFLOAT_MAX)];
    
    return deSize.height;
}
//计算字符串宽度
-(float)calculateStringWidth:(float)height
                        font:(UIFont *)font
{
    UITextView *detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, 0, height)];
    detailTextView.font = font;
    detailTextView.text = self;
    CGSize deSize = [detailTextView sizeThatFits:CGSizeMake(CGFLOAT_MAX,height)];
    
    return deSize.width;
}

- (CGSize)boundingRectWithSize:(CGSize)size fontSize:(NSInteger)font
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    
    CGSize retSize = [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil].size;
    
    return retSize;
}
#pragma mark-时间格式转换
/*************************时间格式转换******************************************/
//时间格式转换
-(NSString*)convertTimeFormatter:(NSString *)formatter toFormatter:(NSString *)toFormatter
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat: formatter];
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    [dateFormatter setDateFormat:toFormatter];
    NSString *newTimeStr = [dateFormatter stringFromDate:destDate];
    return newTimeStr;
}

//NSString转换成NSDate
- (NSDate *)convertStringToDate:(NSString*)dateFormat//dateString格式（yyyy-MM-dd HH:mm:ss）
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: dateFormat];
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    return destDate;
    
}
#pragma mark-字符处理
/*************************字符处理******************************************/
//*符串替换
-(NSString*)startString:(int)startNum//开始替换位置
                 strLen:(int)strLen//替换长度
              character:(NSString*)character//替换字符（e.g*）
{
    NSString* startStr =self.trim;
    NSString*  str =@"";
    NSMutableString *mstr  =[NSMutableString stringWithString:startStr];
    int max =startNum+strLen+1;
    if (mstr.length<max) {
        str =startStr;
        return str;
    }
    NSString* replaceStart =@"";
    for (int index=0; index <strLen; index++) {
        replaceStart= [NSString stringWithFormat:@"%@%@",replaceStart,character];
    }
   
    [mstr replaceCharactersInRange:NSMakeRange(startNum, strLen) withString:replaceStart];
    str =[NSString stringWithFormat:@"%@",mstr] ;
    return str;
}

//提取数字
- (NSString *)stringNumber
{
    
    NSString *onlyNumStr = [self stringByReplacingOccurrencesOfString:@"[^0-9,]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [self length])];
    return onlyNumStr;
}

#pragma mark-MD5加密
- (NSString *) stringMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString ;
}

#pragma mark-验证
/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
-(BOOL) isValidateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePredicate evaluateWithObject:self];
}

/*车牌号验证 MODIFIED BY HELENSONG*/
-(BOOL)validateCarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carPredicate evaluateWithObject:self];
}

#pragma mark-JSON
-(id)stringJsonValue
{
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    __autoreleasing NSError* error = nil;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error != nil) return nil;
    
    return result;
    
}

@end
