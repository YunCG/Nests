//
//  NestsStyleText_1_TableViewCell.h
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
     kSCORE_TYPE_ID_AVIABLE = 1,//可用
     kSCORE_TYPE_ID_CONSUM =2,//消费
      kSCORE_TYPE_ID_EXPIRE =3,//过期
    
}SCORE_TYPE_ID;

@interface NestsStyleText_1_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
-(void)refreshScoreState:(SCORE_TYPE_ID)state;
@end
