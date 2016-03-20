//
//  UIView+Helper.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "UIView+Helper.h"

@implementation UIView (Helper)
//subView
- (UIView*)subViewWithTag:(int)tag
{
    for (UIView* tempView in self.subviews) {
        if (tempView.tag == tag) {
            return tempView;
        }
    }
    return nil;
}

//切圆角
-(void)roundCorners:(float)radius
{
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius = radius;
}
//显示边框
-(void)showViewBorder:(UIColor*)borderColor
          borderWidth:(float)borderWidth
{
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

//圆形图像（比如圆形头像）
-(void)showCircle:(CGFloat)radius//半径
      borderColor:(UIColor*)borderColor//边框颜色
      borderWidth:(CGFloat)borderWidth//边框宽度
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    [self showViewBorder:borderColor borderWidth:borderWidth];
}

@end
