//
//  LibraryAPI.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPClicent.h"

#define  SharedLibraryAPI  [LibraryAPI sharedInstance]
@interface LibraryAPI : NSObject
+ (LibraryAPI*)sharedInstance;
@end
