//
//  CornerShopingAppraiseInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 2/18/16.
//  Copyright © 2016 Daisy. All rights reserved.
//

#import "CornerShopingAppraiseInfoData+Operation.h"

@implementation CornerShopingAppraiseInfoData (Operation)
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
//                 },
//             @{
//                 @"titles" : @[ @"退出登录"],
//                 @"accessory" : @[@NO],
//                 @"alignment" : @[@1]//left:0 center:1 right:2
//                 
//                 
//                 }
//             ];
    
    return self.listArray;
}
@end
