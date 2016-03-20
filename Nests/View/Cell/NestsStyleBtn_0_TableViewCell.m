//
//  NestsStyleBtn_0_TableViewCell.m
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsStyleBtn_0_TableViewCell.h"

@implementation NestsStyleBtn_0_TableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.cellBtn showViewBorder:[UIColor groupTableViewBackgroundColor] borderWidth:1.0];
    [self.cellBtn roundCorners:5];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
