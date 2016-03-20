//
//  NSObject+Helper.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helper)
#pragma mark-UserDefaults
-(void)saveUserDefaultsNotNilWithKey:(NSString *)keyValue;
-(void)saveUserDefaultsNotNil:(NSString *)value
                     keyValue:(NSString *)keyValue;
-(id)objectForUserDefaults:(id)keyValue;
#pragma mark-JSON
-(NSString*)appleJSONString;
@end
