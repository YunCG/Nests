//
//  CornerPersonInfoData.m
//  Nests
//
//  Created by 🐠 on 11/9/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerPersonInfoData.h"

@implementation CornerPersonInfoData
- (id)init {
    self = [super init];
    if (self) {
        self.phoneCode = @"";
        self.phoneNum = @"";
        self.phoneRelNum =@"";
        
        
        self.phoneNumNew = @"";
        self.phoneRelNumNew =@"";
        
        self.phoneValidCode =@"";
        
        self.phoneChangeCode  =@"";
        
        self.isAgree =NO;
        self.isSaveState =NO;
        self.userName = @"";
        self.userImage =NESTS_USER_PHOTO;
       
        
        
        
    }
    return self;
}


- (void)setUserImage:(NSString *)userImage
{
    userImage = userImage.trim;
    if (((NSNull *)userImage == [NSNull null]) || !userImage) {
        userImage = @"";
    }
    
    _userImage = userImage;
}



- (void)setUserName:(NSString *)userName
{
    userName = userName.trim;
    if (((NSNull *)userName == [NSNull null]) || !userName) {
        userName = @"";
    }
    
    _userName = userName;
}

- (void)setPhoneCode:(NSString *)phoneCode
{
    phoneCode = phoneCode.trim;
    if (((NSNull *)phoneCode == [NSNull null]) || !phoneCode) {
        phoneCode = @"";
    }
    

    _phoneCode = phoneCode;
}

- (void)setPhoneNum:(NSString *)phoneNum
{
     phoneNum = phoneNum.trim;
    if (((NSNull *)phoneNum == [NSNull null]) || !phoneNum) {
        phoneNum = @"";
    }
    
    self.phoneRelNum =phoneNum;
    phoneNum=[phoneNum startString:3 strLen:5 character:@"*"];
    _phoneNum = phoneNum;
}


- (void)setPhoneRelNum:(NSString *)phoneRelNum
{
    phoneRelNum = phoneRelNum.trim;
    if (((NSNull *)phoneRelNum == [NSNull null]) || !phoneRelNum) {
        phoneRelNum = @"";
    }
    
    //    phoneNum=[phoneNum startString:3 strLen:5 character:@"*"];
    _phoneRelNum = phoneRelNum;
}




- (void)setPhoneNumNew:(NSString *)phoneNumNew
{
    phoneNumNew = phoneNumNew.trim;
    if (((NSNull *)phoneNumNew == [NSNull null]) || !phoneNumNew) {
        phoneNumNew = @"";
    }
    
    self.phoneRelNumNew =phoneNumNew;
    phoneNumNew=[phoneNumNew startString:3 strLen:5 character:@"*"];
    _phoneNumNew= phoneNumNew;
}


- (void)setPhoneRelNumNew:(NSString *)phoneRelNumNew
{
    phoneRelNumNew = phoneRelNumNew.trim;
    if (((NSNull *)phoneRelNumNew == [NSNull null]) || !phoneRelNumNew) {
        phoneRelNumNew = @"";
    }
    
    //    phoneNum=[phoneNum startString:3 strLen:5 character:@"*"];
    _phoneRelNumNew = phoneRelNumNew;
}


- (void)setPhoneValidCode:(NSString *)phoneValidCode
{
     phoneValidCode = phoneValidCode.trim;
    if (((NSNull *)phoneValidCode == [NSNull null]) || !phoneValidCode) {
        phoneValidCode = @"";
    }
    
    _phoneValidCode = phoneValidCode;
}


- (void)setChangeCode:(NSString *)phoneChangeCode
{
    phoneChangeCode = phoneChangeCode.trim;
    if (((NSNull *)phoneChangeCode == [NSNull null]) || !phoneChangeCode) {
        phoneChangeCode = @"";
    }
    
    _phoneChangeCode = phoneChangeCode;
}

-(BOOL)isValidCode
{
    BOOL isEnable =NO;
    if ([self.phoneCode isEqualToString:self.phoneValidCode]&&(self.phoneCode.length>1)&&(self.phoneValidCode.length>1)) {
         isEnable =YES;
    }
    
    return isEnable;
}


@end
