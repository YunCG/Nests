//
//  CornerNestsResideMenuInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 9/19/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CornerNestsResideMenuInfoData+Operation.h"

@implementation CornerNestsResideMenuInfoData (Operation)
//userInfo
- (NSDictionary*)userInfoDic
{
    
    return@{
                 @"userAvatar" : @[self.userImage],
                 @"userPhone" : @[self.userName],
                 
                 } ;
    
}
//list items
- (NSArray*)arraytableRepresentation
{
    
    if ([self.userUrl.trim  isEqualToString:@""]) {
        
        return @[
                 @{
                     @"titles" : @[ NestsResideMenu_Score, NestsResideMenu_EVALUATE, NestsResideMenu_Message],
                     @"icons" : @[@"zone_nav_jf",
                                  @"zone_nav_pl",
                                  @"zone_nav_message",
                                  @"zone_nav_define"
                                  ],
                     
                     },
                 @{
                     @"titles" : @[NestsResideMenu_More],
                     @"icons" : @[
                             @"zone_nav_more"
                             ],
                     
                     }
                 
                 ];

        
    }
    else
    {
    
        return @[
                 @{
                     @"titles" : @[ NestsResideMenu_Score, NestsResideMenu_EVALUATE, NestsResideMenu_Message, self.userUrlTitle],
                     @"icons" : @[@"zone_nav_jf",
                                  @"zone_nav_pl",
                                  @"zone_nav_message",
                                  @"zone_nav_define"
                                  ],
                     
                     },
                 @{
                     @"titles" : @[NestsResideMenu_More],
                     @"icons" : @[
                             @"zone_nav_more"
                             ],
                     
                     }
                 
                 ];
    }
    
    return nil;
}
@end
