//
//  NestsOffLine_1_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 12/23/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NestsOffLine_1_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;

@property(assign,nonatomic) BOOL isDownLoad;

@end
