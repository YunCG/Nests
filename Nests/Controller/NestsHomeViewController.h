//
//  NestsHomeViewController.h
//  Nests
//
//  Created by 🐠 on 9/12/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController.h"
typedef enum
{
     NESTS_CONTENT_ID_DEFAULT =0,
   NESTS_CONTENT_ID_SCORE =1,
    NESTS_CONTENT_ID_EVALUATE =2,
    NESTS_CONTENT_ID_MESSAGE =3,
    NESTS_CONTENT_ID_WEB =4,
    NESTS_CONTENT_ID_MORE =5,
    NESTS_CONTENT_ID_PERSONINFO =6,

    
    
}NESTS_CONTENT_ID;
@interface NestsHomeViewController : NestsBaseViewController
@property(assign,nonatomic) NESTS_CONTENT_ID contentID;
@property(retain,nonatomic) NSDictionary* infoDic;

@end
