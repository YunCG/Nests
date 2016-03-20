//
//  UIView+Helper.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Helper)
//subView
- (UIView*)subViewWithTag:(int)tag;
//切圆角
-(void)roundCorners:(float)radius;
//显示边框
-(void)showViewBorder:(UIColor*)borderColor
          borderWidth:(float)borderWidth;
//圆形图像（比如圆形头像）
-(void)showCircle:(CGFloat)radius//半径
      borderColor:(UIColor*)borderColor//边框颜色
      borderWidth:(CGFloat)borderWidth;//边框宽度

@end
