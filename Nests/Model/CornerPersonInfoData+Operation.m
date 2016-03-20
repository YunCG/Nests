//
//  CornerPersonInfoData+Operation.m
//  Nests
//
//  Created by 🐠 on 11/9/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerPersonInfoData+Operation.h"

@implementation CornerPersonInfoData (Operation)
- (NSArray*)arraytableRepresentation
{
    return @[
             @{
                 @"titles" : @[ @"头像", @"昵称", @"手机号"],
                 @"values" : @[@"", self.userName,self.phoneNum],
                 @"images" : @[self.userImage,
                              @"",
                              @""
                              ],
                  @"accessory" : @[@YES,@YES,@YES]
               
                 
                 
                 }
             
             ];
}


- (NSArray*)arraytableEditPersonInfoRepresentation
{
    return @[
             @{
                 @"titles" : @[ @"当前手机号码", @"登录密码",@"新手机号"],
                  @"placeholder" : @[self.phoneNum, @"为了你的安全,请验证登录密码",@"请输入更换后的手机号"],
                 @"values" : @[@"", self.phoneValidCode, @""],
                 @"isEnable" : @[@NO, @YES, @YES],
                 //                 @"icons" : @[
                 //                         @"cell_icon_person_0.png",
                 //                         @"cell_icon_person_1.png",
                 //                         @"cell_icon_person_2.png"
                 //                         ],
                 //                  @"values" : @[ @"", @"" ]
                 
                 
                 }
             ];

}

- (NSArray*)arraytableLoginRepresentation
{
    return @[
             @{
                 @"titles" : @[ @"手机号", @"验证码"],
                 @"placeholder" : @[@"请输入手机号", @"请输入短信中的数字验证码"],
                 @"values" : @[self.phoneRelNum, self.phoneCode, ],
                 @"isEnable" : @[@YES, @YES],
                 @"isHiden" : @[@NO, @YES],
                 //                 @"icons" : @[
                 //                         @"cell_icon_person_0.png",
                 //                         @"cell_icon_person_1.png",
                 //                         @"cell_icon_person_2.png"
                 //                         ],
                 //                  @"values" : @[ @"", @"" ]
                 
                 
                 }
             ];
    
}

- (NSArray*)arraytableEditNickNameRepresentation
{
    return @[
             @{
                 @"titles" : @[ @"昵称"],
                 @"placeholder" : @[@"不多于6个字符"],
                 @"values" : @[self.userName],
                  @"isEnable" : @[@YES],
                 //                 @"icons" : @[
                 //                         @"cell_icon_person_0.png",
                 //                         @"cell_icon_person_1.png",
                 //                         @"cell_icon_person_2.png"
                 //                         ],
                 //                  @"values" : @[ @"", @"" ]
                 
                 
                 }
             ];
    
}

- (NSArray*)arraytableEditPhoneRepresentation
{
    return @[
             @{
                 @"titles" : @[ [NSString stringWithFormat:@"已发送短信验证码至手机%@",self.phoneNumNew],@"验证码"],
                 @"placeholder" : @[@"",@"请输入短信中的数字验证码"],
                 @"values" : @[@"",[NSString stringWithFormat:@"%@",self.phoneChangeCode]],
                 @"isEnable" : @[@NO,@YES],
                 //                 @"icons" : @[
                 //                         @"cell_icon_person_0.png",
                 //                         @"cell_icon_person_1.png",
                 //                         @"cell_icon_person_2.png"
                 //                         ],
                 //                  @"values" : @[ @"", @"" ]
                 
                 
                 }
             ];
    
}





@end
