//
//  CornerQCInfoData.m
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerQCInfoData.h"

@implementation CornerQCInfoData
- (id)init {
    self = [super init];
    if (self) {
        self.score = @"";
        self.qcImageUrl = @"";
       
        
        
        
        
    }
    return self;
}

- (void)setScore:(NSString *)score
{
    score = score.trim;
    if (((NSNull *)score == [NSNull null]) || !score) {
        score = @"0";
    }
    
    _score = score;
}


- (void)setQcImageUrl:(NSString *)qcImageUrl
{
    qcImageUrl = qcImageUrl.trim;
    if (((NSNull *)qcImageUrl == [NSNull null]) || !qcImageUrl) {
        qcImageUrl = @"";
    }
    
    _qcImageUrl = qcImageUrl;
}
@end
