//
//  CornerParallaxInfoData+Operation.h
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerParallaxInfoData.h"
#import "NestsParallax_0_TableViewCell.h"
#import "NestsParallax_1_TableViewCell.h"
#import "NestsStylePattern_0_TableViewCell.h"
#import "NestsStylePattern_1_TableViewCell.h"
#import "NestsStylePattern_2_TableViewCell.h"
#import "NestsShopingAppraiseTableViewCell.h"

#define  kNestsParallax_0_TableViewCell  @"NestsParallax_0_TableViewCell"
#define kNestsParallax_1_TableViewCell @"NestsParallax_1_TableViewCell"
#define kNestsStylePattern_0_TableViewCell @"NestsStylePattern_0_TableViewCell"
#define kNestsStylePattern_1_TableViewCell @"NestsStylePattern_1_TableViewCell"
#define kNestsStylePattern_2_TableViewCell @"NestsStylePattern_2_TableViewCell"

#define kNestsShopingAppraiseTableViewCell @"NestsShopingAppraiseTableViewCell"

#define kNestsDefault_TableViewCell @"NestsDefault_TableViewCell"




@interface CornerParallaxInfoData (Operation)
- (NSArray*)arraytableRepresentation;
@end
