//
//  NetworkHelper.h
//  Skeleton
//
//  Created by 🐠 on 3/16/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NetworkConfigs.h"


#define SharedNetworkHelper [NetworkHelper sharedInstance]
@interface NetworkHelper : NSObject
// init
+ (id)sharedInstance;
// BaseURL
- (NSString*)netBaseURL;
// AppURL
- (NSString*)netAppURL:(NET_REQUEST_ID)requestID;
//downLoadTemp
- (NSString*)dowLoadTempleFile:(NSString*)fileName;
@end
