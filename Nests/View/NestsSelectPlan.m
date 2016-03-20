//
//  NestsSelectPlan.m
//  Nests
//
//  Created by 🐠 on 11/17/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsSelectPlan.h"

@implementation NestsSelectPlan

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnAction:(id)sender {
    
    UIButton* btn =sender;
    NSInteger selectIndex =btn.tag;
    
    CGRect frame =self.slider.frame;
    switch (selectIndex) {
        case  100:
        {
            frame.origin.x =40;
        }
            break;
        case  101:
        {
            frame.origin.x =150;
        }
            break;
        case  102:
        {
             frame.origin.x =260;
        }
            break;
            
        default:
            break;
    }
    
    
    self.slider.frame= frame;
    
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectPlanIndex:)])
    {
        [self.delegate selectPlanIndex:selectIndex];
    }
}


@end
