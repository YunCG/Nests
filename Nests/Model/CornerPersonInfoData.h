//
//  CornerPersonInfoData.h
//  Nests
//
//  Created by 🐠 on 11/9/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CornerPersonInfoData : NSObject

@property(nonatomic,assign) BOOL  isAgree;
@property(nonatomic,assign) BOOL  isSaveState;
@property(nonatomic,copy) NSString* phoneNum;
@property(nonatomic,copy) NSString* phoneRelNum;

@property(nonatomic,copy) NSString* phoneNumNew;
@property(nonatomic,copy) NSString* phoneRelNumNew;

@property(nonatomic,copy) NSString* phoneCode;
@property(nonatomic,copy) NSString* phoneValidCode;


@property(nonatomic,copy) NSString* phoneChangeCode;//新手机获得的验证码



@property(nonatomic,copy) NSString* userName;
@property(nonatomic,copy) NSString* userImage;

-(BOOL)isValidCode;
@end
