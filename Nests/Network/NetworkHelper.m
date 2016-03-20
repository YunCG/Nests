//
//  NetworkHelper.m
//  Skeleton
//
//  Created by 🐠 on 3/16/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NetworkHelper.h"

@implementation NetworkHelper
#pragma mark - init
+ (id)sharedInstance {
  // 1
  static NetworkHelper* _sharedInstance = nil;

  // 2
  static dispatch_once_t oncePredicate;

  // 3
  dispatch_once(&oncePredicate, ^{
    _sharedInstance = [[NetworkHelper alloc] init];
  });
  return _sharedInstance;
}
#pragma mark - URL
// BaseURL
- (NSString*)netBaseURL
{
  NSString* url = [NSString stringWithFormat:@"%@", NET_BASE_URL];
  DDDebug(@"App Base URL:%@", url);
  return url;
}

/********************************系统接口*********************************************/
// AppURL
- (NSString*)netAppURL:(NET_REQUEST_ID)requestID
{
    
    NSString* URLString =[self netURLString:requestID];
    
    NSString* url = [NSString stringWithFormat:@"%@%@", NET_BASE_URL,URLString];
    DDDebug(@"%@>>>>>>>>>>>>>>>>>>>>>>URL:%@",URLString, url);
    return url;
}

//downLoadTemp
- (NSString*)dowLoadTempleFile:(NSString*)fileName
{
    NSTimeInterval  timeZoneOffset=[[NSTimeZone systemTimeZone] secondsFromGMT];
    NSString *tmpDir = [NestsKit sandBoxTempPath];
    NSString *pathTemp =[tmpDir stringByAppendingFormat:@"/%lf_%@",timeZoneOffset,fileName];
  
    return pathTemp;
    
}


-(NSString*)netURLString:(NET_REQUEST_ID)requestID
{
    NSString* requestURL =nil;
    switch (requestID) {
        case NET_APP_LAUNCH_ID:
        {
            requestURL =NET_APP_LAUNCH_PATH;
        }
            break;
        case NET_USER_SECURITY_ID:
        {
            requestURL =NET_USER_SECURITY_PATH;
        }
            break;
        case NET_USER_LOGIN_ID:
        {
            requestURL =NET_USER_LOGIN_PATH;
        }
            break;
        case NET_USER_QR_ID:
        {
            requestURL =NET_USER_QR_PATH;
        }
            break;
        case NET_USER_PERSON_INFO_ID:
        {
            requestURL =NET_USER_PERSON_INFO_PATH;
        }
            break;
        case NET_USER_PERSON_PHOTO_ID:
        {
            requestURL =NET_USER_PERSON_PHOTO_PATH;
        }
            break;
        case NET_USER_PERSON_NICKNAME_ID:
        {
            requestURL =NET_USER_PERSON_NICKNAME_PATH;
        }
            break;
        case  NET_USER_PERSON_PHONE_ID :
        {
            requestURL = NET_USER_PERSON_PHONE_PATH;
        }
            break;
        case  NET_USER_SING_OUT_ID:
        {
            requestURL = NET_USER_SING_OUT_PATH;
        }
            break;
        case  NET_MER_SHOPINGKEPPER_LIST_ID:
        {
            requestURL = NET_MER_SHOPINGKEPPER_LIST_PATH;
        }
            break;
        case NET_MER_SHOPINGKEPPER_INFO_ID:
        {
            requestURL =NET_MER_SHOPINGKEPPER_INFO_PATH;
        }
            break;
        case NET_MER_EVALUATE_ALL_ID:
        {
            requestURL =NET_MER_EVALUATE_ALL_PATH;
        }
            break;
        case  NET_MER_SCORE_ID:
        {
            requestURL = NET_MER_SCORE_PATH;
        }
            break;
        case  NET_MER_EVALUATE_ID:
        {
            requestURL = NET_MER_EVALUATE_PATH;
        }
            break;
        case NET_MER_EVALUATE_MINE_ID:
        {
            requestURL =NET_MER_EVALUATE_MINE_PATH;
        }
            break;
        case NET_MER_EVALUATE_DETAIL_ID:
        {
            requestURL =NET_MER_EVALUATE_DETAIL_PATH;
        }
            break;
        case NET_DOWND_SQLLITE_ID:
        {
            requestURL =NET_DOWND_SQLLITE_PATH;
        }
            break;
        
            
        default:
            
            break;
    }

    return requestURL;
}

@end
