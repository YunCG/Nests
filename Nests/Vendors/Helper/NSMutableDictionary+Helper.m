//
//  NSMutableDictionary+Helper.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NSMutableDictionary+Helper.h"

@implementation NSMutableDictionary (Helper)
- (void)saveValueNotNil:(id)value
                 forKey:(NSString *)key {
    id saveValue =value?value:@"";
    [self setValue:saveValue forKey:key];
    
}
@end
