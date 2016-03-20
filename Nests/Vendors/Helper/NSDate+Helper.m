//
//  NSDate+Helper.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)
//NSDate转换成NSString
+ (NSString *)convertDateToString:(NSString*)dateFormat//dateString格式（yyyy-MM-dd HH:mm:ss）
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:dateFormat];
    NSString *destDateString = [dateFormatter stringFromDate:self];
    
    return destDateString;
    
}
@end
