//
//  CornerParallaxInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerParallaxInfoData+Operation.h"

@implementation CornerParallaxInfoData (Operation)

- (NSArray*)arraytableRepresentation
{
    return @[
             @{
                 @"identifier": @[ kNestsParallax_0_TableViewCell, kNestsStylePattern_0_TableViewCell],
                  @"rows" :@2,
                 kNestsParallax_0_TableViewCell:@{
                         @"titles" :self.name,
                         @"describe" :self.desc,
                          @"describeColor" :@"{0.67,0.67,0.67}",
                          @"evalueValues" :@2.5,
                         @"accessory":@NO,
                          @"noLine":@YES
                         
                         },
                 kNestsStylePattern_0_TableViewCell:@{//评价
                         @"titles" :self.name,
                         @"describe" :self.desc,
                          @"describeColor" :@"{0.67,0.67,0.67}",
                          @"accessory":@NO,
                         }
                 
                 },
             @{
                 @"identifier": @[ kNestsParallax_1_TableViewCell, kNestsStylePattern_0_TableViewCell,kNestsStylePattern_1_TableViewCell,],
                   @"rows" :@3,
                 kNestsParallax_1_TableViewCell:@{
                         @"titles" :@"优惠信息",
                         @"describe" :self.favorable,
                         @"accessory":@NO
                         
                         },
                 kNestsStylePattern_0_TableViewCell:@{
                          @"titles" :@"优惠信息",
                          @"describe" :@"实际支付金额满100元，赠送获得5积分",
                          @"describeColor" :@"{0.67,0.67,0.67}",
                          @"accessory":@NO,
                         }
                 ,
                 kNestsStylePattern_1_TableViewCell:@{
                         @"titles" :self.addr,
                         @"accessory":@YES,
                         @"icons" :@"index_list_dw",
                         }
                 
                 }
             ,
             @{
                 @"identifier": @[kNestsStylePattern_2_TableViewCell],
                   @"rows" :@1,
                 kNestsStylePattern_2_TableViewCell:@{
                         @"btnTitles" :self.phone,
                         @"btnImage" :@"sjxq_call",
                         @"accessory":@NO
                         
                         }
                 
                 }
             ,
             @{
                 @"identifier": @[kNestsShopingAppraiseTableViewCell],
                   @"rows" :@1,
                 kNestsShopingAppraiseTableViewCell:@{
                         @"accessory":@NO
                         }
                 
                 }
             ];
}

@end
