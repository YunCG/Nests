//
//  NSObject+Helper.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)
#pragma mark-UserDefaults
-(void)saveUserDefaultsNotNilWithKey:(NSString *)keyValue
{
    id saveValue =self?self:@"";
    [[NSUserDefaults standardUserDefaults] setObject:saveValue forKey:keyValue];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)saveUserDefaultsNotNil:(NSString *)value
                        keyValue:(NSString *)keyValue
{
    id saveValue =value?value:@"";
    [[NSUserDefaults standardUserDefaults] setObject:saveValue forKey:keyValue];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(id)objectForUserDefaults:(id)keyValue
{
    id value = [[NSUserDefaults standardUserDefaults] objectForKey:keyValue];
    return  value;
}


#pragma mark-JSON
-(NSString*)appleJSONString

{
    NSString* jsonString =nil;
    
    NSError* error = nil;
    
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    
    
    if (error != nil)
    {
        NSLog(@"json解析错误:%@",error.domain);
    }
    else
    {
        jsonString =[NSString stringWithFormat:@"%@",result];
    }
    
    
    return jsonString;
    
}
@end
