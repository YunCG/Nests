//
//  NestsStyleSubtitle_0_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/21/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"
#import "StarRatingDelegate.h"


@interface NestsStyleSubtitle_0_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *subIcon;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (nonatomic,retain) HCSStarRatingView *starRatingView ;
@property(assign,nonatomic) id<StarRatingDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
