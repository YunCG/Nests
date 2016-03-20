//
//  NestsMapViewController.h
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface NestsMapViewController : NestsBaseViewController
@property(nonatomic,retain)NSArray* annotaitonArray;
@property(nonatomic,assign)BOOL isLocation;
@property(nonatomic,assign)BOOL isShowNearby;
@property(nonatomic,retain)MAPointAnnotation* desPoint;
@end
