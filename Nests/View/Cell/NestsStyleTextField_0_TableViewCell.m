//
//  NestsStyleTextField_0_TableViewCell.m
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsStyleTextField_0_TableViewCell.h"

@implementation NestsStyleTextField_0_TableViewCell

- (void)awakeFromNib {
    // Initialization code
     [self.contentTextField  setDelegate:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark- textFiled delegat
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textField====%@",textField.text);
    NSString* text  =textField.text;
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(textFieldCellDidEndEditing:section:row:)]) {
        [self.delegate textFieldCellDidEndEditing:text section:self.section row:self.row];
    }
}

@end
