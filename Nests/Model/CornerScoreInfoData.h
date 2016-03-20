//
//  CornerScoreInfoData.h
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CornerScoreInfoData : NSObject
@property(copy,nonatomic) NSString* availableScore;//可用积分
@property(copy,nonatomic) NSString* consumeScore;//消费积分
@property(copy,nonatomic) NSString* expireScore;//可用积分

@property(retain,nonatomic) NSMutableArray* listArray;

@end
