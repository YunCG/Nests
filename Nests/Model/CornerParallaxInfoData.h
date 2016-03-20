//
//  CornerParallaxInfoData.h
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CornerParallaxInfoData : NSObject
@property(nonatomic,copy) NSString* mId;//商家ID
@property(nonatomic,copy) NSString* name;//商家名
@property(nonatomic,copy) NSString* addr;//地址
@property(nonatomic,copy) NSString* logo;//商家图标
@property(nonatomic,copy) NSString* lng;//经度
@property(nonatomic,copy) NSString* lat;//纬度
@property(nonatomic,copy) NSString* range;//距离 如果为0，不显示
@property(nonatomic,copy) NSString* desc;//描述
@property(nonatomic,copy) NSString* favorable;//优惠信息
@property(nonatomic,copy) NSString* phone;//商家电话

@property(nonatomic,copy) NSString* goodReptRate;//好评率

@property(nonatomic,copy) NSString* recCount;//记录数

@property(nonatomic,copy) NSNumber* goodReptRateValue;//好评率

@property(nonatomic,retain) NSMutableArray* listArray;//评价


@end
