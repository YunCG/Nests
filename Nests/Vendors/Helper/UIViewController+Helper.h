//
//  UIViewController+Helper.h
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helper)
- (void)backPopViewController:(UIButton*)sender;
//键盘消失
- (void)resignKeyBoardInView:(UIView *)view;
@end
