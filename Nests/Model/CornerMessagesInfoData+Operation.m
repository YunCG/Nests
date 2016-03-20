//
//  CornerMessagesInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 9/13/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CornerMessagesInfoData+Operation.h"

@implementation CornerMessagesInfoData (Operation)
- (NSArray*)arraytableRepresentation
{
//    return @[
//             @{
//                 @"titles" : @[ @"sqlite 如果表不存在创建表", @"sqlite 如果表不存在创建表"],
//                 @"detail" : @[ @"2015-10-10 12:30", @"2015-10-10 12:30"],
//                 @"isRead" :  @[@YES, @NO],
//                 @"accessory" : @[@NO, @NO],
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
    
        self.messagesArray =[SharedNestsSQLite queryRemoteMessages];
    
    return  self.messagesArray ;
}
@end
