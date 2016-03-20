//
//  NestsParallax_0_TableViewCell.m
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsParallax_0_TableViewCell.h"

@implementation NestsParallax_0_TableViewCell

- (void)awakeFromNib {
    // Initialization code
    _starRatingView = [[HCSStarRatingView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.starView.frame), CGRectGetHeight(self.starView.frame))];
    _starRatingView.maximumValue = 5.0;
    _starRatingView.minimumValue = 0.0;
    _starRatingView.allowsHalfStars = YES;
    _starRatingView.value = 0.0;
    //    _starRatingView.tintColor = [UIColor redColor];
    
    
    _starRatingView.emptyStarImage = [UIImage imageNamed:@"zone_pj_star_3"];
    _starRatingView.halfStarImage = [UIImage imageNamed:@"zone_pj_star_2"]; // optional
    _starRatingView.filledStarImage = [UIImage imageNamed:@"zone_pj_star_1"];
    
    [_starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.starView addSubview:_starRatingView];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(void)didChangeValue:(id)sender
{
    NSLog(@"你选择了＝＝%@",sender);
    
    if ([sender  isKindOfClass:[HCSStarRatingView class]]) {
        HCSStarRatingView* start =sender;
        NSNumber* startValue =[NSNumber numberWithFloat:start.value];
        
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(didRatingValue:)]) {
            [self.delegate didRatingValue:startValue];
        }
    }
    
    
    
    
}

@end
