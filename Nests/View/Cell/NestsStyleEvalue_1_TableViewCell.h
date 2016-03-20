//
//  NestsStyleEvalue_1_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/22/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldCellDelegate.h"
@interface NestsStyleEvalue_1_TableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property(assign,nonatomic) NSInteger section;
@property(assign,nonatomic) NSInteger row;
@property(nonatomic) id delegate;
@end
