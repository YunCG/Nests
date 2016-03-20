//
//  CornerNestsResideMenuInfoData+Operation.h
//  Nests
//
//  Created by 🐠 on 9/19/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CornerNestsResideMenuInfoData.h"
#define NestsResideMenu_Score @"我的积分"
#define NestsResideMenu_EVALUATE @"我的评价"
#define NestsResideMenu_Message @"我的消息"
#define NestsResideMenu_More @"更多"
@interface CornerNestsResideMenuInfoData (Operation)
- (NSDictionary*)userInfoDic;
- (NSArray*)arraytableRepresentation;
@end
