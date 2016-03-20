//
//  CornerMessagesInfoData.m
//  Nests
//
//  Created by 🐠 on 9/13/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CornerMessagesInfoData.h"

@implementation CornerMessagesInfoData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messagesArray =[SharedNestsSQLite queryRemoteMessages];
    }
    return self;
}


@end
