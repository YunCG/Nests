//
//  NestsStyleText_1_TableViewCell.m
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsStyleText_1_TableViewCell.h"

@implementation NestsStyleText_1_TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)refreshScoreState:(SCORE_TYPE_ID)state
{
    switch (state) {
        case kSCORE_TYPE_ID_AVIABLE:
        {
            [self.scoreLabel  setTextColor:[UIColor colorWithRed:0.99 green:0.74 blue:0.17 alpha:1.0]];
        }
            break;
        case kSCORE_TYPE_ID_CONSUM:
        {
              [self.scoreLabel  setTextColor:[UIColor colorWithRed:0.66 green:0.83 blue:0.21 alpha:1.0]];
        }
            break;
        case kSCORE_TYPE_ID_EXPIRE:
        {
              [self.scoreLabel  setTextColor:[UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1.0]];
        }
            break;
            
        default:
            break;
    }
}
@end
