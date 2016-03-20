//
//  CornerScoreInfoData.m
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerScoreInfoData.h"

@implementation CornerScoreInfoData
- (id)init {
    self = [super init];
    if (self) {
        self.availableScore = @"";
        self.consumeScore = @"";
        self.expireScore =@"";
        self.listArray =[[NSMutableArray alloc] initWithCapacity:1];

    }
    return self;
}


- (void)setAvailableScore:(NSString *)availableScore
{
    availableScore = availableScore.trim;
    if (((NSNull *)availableScore == [NSNull null]) || !availableScore) {
        availableScore = @"";
    }
    
    _availableScore = availableScore;
}


- (void)setConsumeScore:(NSString *)consumeScore
{
    consumeScore = consumeScore.trim;
    if (((NSNull *)consumeScore == [NSNull null]) || !consumeScore) {
        consumeScore = @"";
    }
    
    _consumeScore = consumeScore;
}

- (void)setExpireScore:(NSString *)expireScore
{
    expireScore = expireScore.trim;
    if (((NSNull *)expireScore == [NSNull null]) || !expireScore) {
        expireScore = @"";
    }
    
    _expireScore = expireScore;
}

@end
