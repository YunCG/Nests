//
//  NestsSelectPlan.h
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NestsSelectPlanDelegae <NSObject>

-(void)selectPlanIndex:(NSInteger)selectIndex;
@end

@interface NestsSelectPlan : UIView
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnArray;
@property (weak, nonatomic) IBOutlet UIImageView *slider;
@property (weak, nonatomic) IBOutlet UILabel *ableScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *overLabel;
@property (nonatomic,assign) id  delegate;
- (IBAction)btnAction:(id)sender;

@end
