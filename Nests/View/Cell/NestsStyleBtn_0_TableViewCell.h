//
//  NestsStyleBtn_0_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NestsStyleBtn_0_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellBtn;
@property(assign,nonatomic) NSInteger section;
@property(assign,nonatomic) NSInteger row;

@end
