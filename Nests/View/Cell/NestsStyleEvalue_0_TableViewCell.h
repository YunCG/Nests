//
//  NestsStyleEvalue_0_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/22/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "StarRatingDelegate.h"


@interface NestsStyleEvalue_0_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (nonatomic,retain) HCSStarRatingView *starRatingView ;
@property(assign,nonatomic) id<StarRatingDelegate> delegate;
@end
