//
//  CornerScoreInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerScoreInfoData+Operation.h"

@implementation CornerScoreInfoData (Operation)
- (NSArray*)arraytableRepresentation
{
//    return @[
//             @{
//                 @"titles" : @[ @"离线地图管理", @"关于"],
//                 @"accessory" : @[@YES, @YES],
//                 @"alignment" : @[@0,@0]//left:0 center:1 right:2
//                 //                 @"icons" : @[
//                 //                         @"cell_icon_person_0.png",
//                 //                         @"cell_icon_person_1.png",
//                 //                         @"cell_icon_person_2.png"
//                 //                         ],
//                 //                  @"values" : @[ @"", @"" ]
//                 
//                 
//                 }
//             ];
    
    return self.listArray;
}
@end
