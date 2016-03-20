//
//  LibraryAPI.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "LibraryAPI.h"


@interface LibraryAPI ()
@property(nonatomic, retain) ASIHTTPClicent *networkClient;
@property(nonatomic, assign) BOOL isOnline;
@end

@implementation LibraryAPI
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


+ (LibraryAPI*)sharedInstance
{
    // 1
    static LibraryAPI *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}
#pragma mark-commonAction
@end
