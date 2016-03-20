//
//  NestsParallax_0_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "StarRatingDelegate.h"
@interface NestsParallax_0_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *describLabel;
@property (nonatomic,retain) HCSStarRatingView *starRatingView ;
@property(assign,nonatomic) id<StarRatingDelegate> delegate;
@end
