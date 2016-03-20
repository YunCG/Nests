//
//  CornerQCInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerQCInfoData+Operation.h"

@implementation CornerQCInfoData (Operation)
- (NSArray*)arraytableRepresentation
{
    return @[
             @{
                 @"titles" : @[self.score],
                 @"images" : @[self.qcImageUrl],
                 
                 
                 }
             ];
}
@end
