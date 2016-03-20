//
//  MAForAnnotationView.h
//  Nests
//
//  Created by 🐠 on 9/20/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "MACalloutView.h"
@interface MAForAnnotationView : MAAnnotationView//若继承MAAnnotationView，则需要设置标注图标；若继承MAPinAnnotationView，使用默认的大头针标注。
@property (nonatomic, readonly) MACalloutView *calloutView;
@end
