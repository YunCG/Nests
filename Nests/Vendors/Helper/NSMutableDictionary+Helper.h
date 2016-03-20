//
//  NSMutableDictionary+Helper.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Helper)
- (void)saveValueNotNil:(id)value
                 forKey:(NSString *)key;
@end
