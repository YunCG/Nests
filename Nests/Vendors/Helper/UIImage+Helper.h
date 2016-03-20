//
//  UIImage+Helper.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)
//创建纯色图片
+(UIImage *)createColorImg:(UIColor *)color
                      rect:(CGRect)rect;

//创建纯色图片(圆)
+(UIImage *)createColorEllipseImg:(UIColor *)color
                             rect:(CGRect)rect;
@end
