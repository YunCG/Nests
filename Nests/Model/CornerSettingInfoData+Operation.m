//
//  CornerSettingInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 9/13/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CornerSettingInfoData+Operation.h"

@implementation CornerSettingInfoData (Operation)
- (NSArray*)arraytableRepresentation
{
    return @[
             @{
                 @"titles" : @[ @"离线地图管理", @"关于"],
                 @"accessory" : @[@YES, @YES],
                  @"alignment" : @[@0,@0]//left:0 center:1 right:2
                 //                 @"icons" : @[
                 //                         @"cell_icon_person_0.png",
                 //                         @"cell_icon_person_1.png",
                 //                         @"cell_icon_person_2.png"
                 //                         ],
//                  @"values" : @[ @"", @"" ]
               
                 
                 },
             @{
                 @"titles" : @[ @"退出登录"],
                 @"accessory" : @[@NO],
                 @"alignment" : @[@1]//left:0 center:1 right:2
                
                 
                 }
                         ];
}
@end
