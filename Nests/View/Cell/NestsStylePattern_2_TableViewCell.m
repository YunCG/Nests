//
//  NestsStylePattern_2_TableViewCell.m
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsStylePattern_2_TableViewCell.h"

@implementation NestsStylePattern_2_TableViewCell

- (void)awakeFromNib {
    // Initialization code
//    [self.cellBtn setStyle:BButtonStyleBootstrapV3];
//    [self.cellBtn setColor:[UIColor colorWithRed:0.99 green:0.75 blue:0.0 alpha:1.0]];
    [self.cellBtn setBackgroundColor:[UIColor colorWithRed:0.99 green:0.75 blue:0.0 alpha:1.0]];
    [self.cellBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [self.cellBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateHighlighted];
   }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
