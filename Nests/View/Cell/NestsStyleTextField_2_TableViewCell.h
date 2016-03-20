//
//  NestsStyleTextField_2_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCellDelegate.h"

@interface NestsStyleTextField_2_TableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property(assign,nonatomic) NSInteger section;
@property(assign,nonatomic) NSInteger row;
@property(nonatomic) id delegate;

@end
