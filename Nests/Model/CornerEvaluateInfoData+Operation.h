//
//  CornerEvaluateInfoData+Operation.h
//  Nests
//
//  Created by 🐠 on 11/21/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerEvaluateInfoData.h"
typedef enum
{
    EvaluateID_Will =1,
    EvaluateID_Over =2
    
}EvaluateID;

#define  kNestsStyleSubtitle_0_TableViewCell  @"NestsStyleSubtitle_0_TableViewCell"
#define kNestsStyleEvalue_0_TableViewCell @"NestsStyleEvalue_0_TableViewCell"
#define kNestsStyleEvalue_1_TableViewCell @"NestsStyleEvalue_1_TableViewCell"
#define kNestsStyleText_0_TableViewCell @"NestsStyleText_0_TableViewCell"
@interface CornerEvaluateInfoData (Operation)
- (NSArray*)arraytableRepresentation:(EvaluateID)evaluateState;
- (NSArray*)arraytableRepresentationEdit:(NSDictionary*)infoDic;//修改
- (NSArray*)arraytableRepresentationDetail:(NSDictionary*)infoDic;//修改
@end
