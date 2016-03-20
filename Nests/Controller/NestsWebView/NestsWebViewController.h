//
//  NestsWebViewController.h
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController.h"
#define NESTS_WEB_TITLE @"NESTS_WEB_TITLE"
#define NESTS_WEB_LINK @"NESTS_WEB_LINK"
#define NESTS_WEB_POP_TYPE @"NESTS_WEB_POP_TYPE"

typedef enum
{
    WebPopTypeID_Default =0,
    WebPopTypeID_Left =1,

}WebPopTypeID;


@interface NestsWebViewController : NestsBaseViewController
@property(nonatomic,retain)NSDictionary* infoDic;
@end
