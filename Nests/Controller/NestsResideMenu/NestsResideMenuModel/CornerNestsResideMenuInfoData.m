//
//  CornerNestsResideMenuInfoData.m
//  Nests
//
//  Created by 🐠 on 9/19/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "CornerNestsResideMenuInfoData.h"

@implementation CornerNestsResideMenuInfoData
- (id)init {
    self = [super init];
    if (self) {
        self.userName = @"";
        self.userUrlTitle =  [SharedNestsHelper userDefineUrlTitle];
        self.userUrl = [SharedNestsHelper userDefineUrl];
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


- (void)setUserUrlTitle:(NSString *)userUrlTitle
{
    userUrlTitle = userUrlTitle.trim;
    if (((NSNull *)userUrlTitle == [NSNull null]) || !userUrlTitle) {
        userUrlTitle = @"";
    }
    
    _userUrlTitle = userUrlTitle;
}

- (void)setUserUrl:(NSString *)userUrl
{
    userUrl = userUrl.trim;
    if (((NSNull *)userUrl == [NSNull null]) || !userUrl) {
        userUrl = @"";
    }
    
    _userUrl = userUrl;
}
@end
