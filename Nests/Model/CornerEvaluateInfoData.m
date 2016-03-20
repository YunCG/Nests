//
//  CornerEvaluateInfoData.m
//  Nests
//
//  Created by 🐠 on 11/21/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerEvaluateInfoData.h"

@implementation CornerEvaluateInfoData
- (id)init {
    self = [super init];
    if (self) {
       
        self.score =@"5.0";
        self.evaluate =@"";
        self.limit =@"0/100";
        self.dataTime =@"";
        self.listArray =[[NSMutableArray alloc] initWithCapacity:1];
          }
    return self;
}
- (void)setLimit:(NSString *)limit
{
    limit = limit.trim;
    if (((NSNull *)limit == [NSNull null]) || !limit) {
        limit = @"0/100";
    }
    _limit = limit;
}

- (void)setScore:(NSString *)score
{
    score = score.trim;
    if (((NSNull *)score == [NSNull null]) || !score) {
        score = @"5.0";
    }
    _score = score;
}

- (void)setEvaluate:(NSString *)evaluate
{
    evaluate = evaluate.trim;
    if (((NSNull *)evaluate == [NSNull null]) || !evaluate) {
        evaluate = @"";
    }
    _evaluate = evaluate;
}

-(void)setDataTime:(NSString *)dataTime
{
    dataTime = dataTime.trim;
    if (((NSNull *)dataTime == [NSNull null]) || !dataTime) {
        dataTime = @"";
    }
    _dataTime = dataTime;

}

@end
