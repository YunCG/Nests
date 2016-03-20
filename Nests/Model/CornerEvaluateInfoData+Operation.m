//
//  CornerEvaluateInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 11/21/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerEvaluateInfoData+Operation.h"

@implementation CornerEvaluateInfoData (Operation)
- (NSArray*)arraytableRepresentation:(EvaluateID)evaluateState
{

//    NSArray* array =[self arraytableRepresentationWill];
//    switch (evaluateState) {
//        case EvaluateID_Will:
//        {
//          array =[self arraytableRepresentationWill];
//        }
//            break;
//        case EvaluateID_Over:
//        {
//              array =[self arraytableRepresentationOver];
//        }
//            break;
//            
//        default:
//            break;
//    }
 
    return self.listArray;
}

- (NSArray*)arraytableRepresentationWill//待评价
{
    return @[
             @{
                 @"titles" : @[ @"观音桥鱼头火锅", @"观音桥鱼头火锅"],
                 @"accessory" : @[@YES, @YES],
                 @"subTitles" : @[ @"消费 200元", @"消费 200元"],
                 @"icons" : @[@"https://tse1-mm.cn.bing.net/th?id=OIP.M7694fe5dc21e6913d37ce2d5b48698c8o0&pid=15.1",
                              @"https://tse1-mm.cn.bing.net/th?id=OIP.M7694fe5dc21e6913d37ce2d5b48698c8o0&pid=15.1"
                              ],
                   @"evalueValue" : @[@0, @0],
                 
     
                 
                 
                 }
             ];
}
- (NSArray*)arraytableRepresentationOver//已评价
{
    return @[
             @{
                 @"titles" : @[ @"观音桥鱼头火锅", @"观音桥鱼头火锅"],
                 @"accessory" : @[@NO, @NO],
                 @"subTitles" : @[ @"消费 200元", @"消费 200元"],
                 @"icons" : @[@"https://tse1-mm.cn.bing.net/th?id=OIP.M7694fe5dc21e6913d37ce2d5b48698c8o0&pid=15.1",
                              @"https://tse1-mm.cn.bing.net/th?id=OIP.M7694fe5dc21e6913d37ce2d5b48698c8o0&pid=15.1"
                              ],
                 @"evalueValue" : @[@5, @3.5],
                 
                 
                 
                 
                 }
             ];
}

- (NSArray*)arraytableRepresentationEdit:(NSDictionary*)infoDic//修改
{
    return @[
             @{
                 @"identifier": @[ kNestsStyleSubtitle_0_TableViewCell, kNestsStyleEvalue_0_TableViewCell, kNestsStyleEvalue_1_TableViewCell],
                 kNestsStyleSubtitle_0_TableViewCell:@{
                          @"titles" :infoDic[@"name"],
                           @"subTitles" :infoDic[@"addr"],
                           @"icons" : infoDic[@"logo"],
                           @"subIcons" :@"index_list_dw",
                           @"accessory":@NO
                          
                         },
                 kNestsStyleEvalue_0_TableViewCell:@{
                          @"titles" :@"评分",
                           @"accessory":@NO,
                           @"evalueValues" :self.score,
                         },
                 kNestsStyleEvalue_1_TableViewCell:@{
                         @"titles" :@"评价",
                         @"accessory":@NO,
                         @"values" :self.evaluate,
                         @"placeholder" :@"写下您对商家的服务感受!"
                         }
                
                 
                 }
             ];
}

- (NSArray*)arraytableRepresentationDetail:(NSDictionary*)infoDic//详情
{
    return @[
             @{
                 @"identifier": @[ kNestsStyleSubtitle_0_TableViewCell, kNestsStyleEvalue_0_TableViewCell, kNestsStyleEvalue_1_TableViewCell,kNestsStyleText_0_TableViewCell],
                 kNestsStyleSubtitle_0_TableViewCell:@{
                         @"titles" :infoDic[@"name"],
                         @"subTitles" :infoDic[@"addr"],
                         @"icons" : infoDic[@"logo"],
                         @"subIcons" :@"index_list_dw",
                         @"accessory":@YES
                         
                         },
                 kNestsStyleEvalue_0_TableViewCell:@{
                         @"titles" :@"评分",
                         @"accessory":@NO,
                         @"evalueValues" :infoDic[@"score"],
                         },
                 kNestsStyleEvalue_1_TableViewCell:@{
                         @"titles" :@"评价",
                         @"accessory":@NO,
                         @"values" :self.evaluate,
                         @"placeholder" :@"不错！不错"
                         }
                 ,
                 kNestsStyleText_0_TableViewCell:@{
                         @"titles" :@"时间",
                         @"accessory":@NO,
                         @"values" :self.dataTime,
                         
                         }
                 
                 
                 }
             ];
}
@end
