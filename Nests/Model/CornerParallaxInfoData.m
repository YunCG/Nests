//
//  CornerParallaxInfoData.m
//  Nests
//
//  Created by 🐠 on 11/29/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerParallaxInfoData.h"

@implementation CornerParallaxInfoData
- (id)init {
    self = [super init];
    if (self) {
        self.mId = @"";//商家ID
        self.name = @"";//商家名
        self.addr = @"";//地址
        self.logo = @"";//商家图标
        self.lng = @"";//经度
        self.lat = @"";//纬度
        self.range = @"";//距离 如果为0，不显示
        self.desc = @"";//描述
        self.favorable = @"";//优惠信息
        self.phone = @"";//商家电话
        self.goodReptRate = @"";//好评率
        self.recCount = @"0";//记录数
        
        self.goodReptRateValue =@0.25;
        
        self.listArray =[[NSMutableArray alloc] initWithCapacity:1];
        
        
        
    }
    return self;
}

- (void)setMId:(NSString *)mId
{
    mId = mId.trim;
    if (((NSNull *)mId == [NSNull null]) || !mId) {
        mId = @"";
    }
    _mId = mId;
}

- (void)setName:(NSString *)name
{
    name = name.trim;
    if (((NSNull *)name == [NSNull null]) || !name) {
        name = @"";
    }
    _name = name;
}
- (void)setAddr:(NSString *)addr
{
    addr = addr.trim;
    if (((NSNull *)addr == [NSNull null]) || !addr) {
        addr = @"";
    }
    _addr = addr;
}
- (void)setLogo:(NSString *)logo
{
    logo = logo.trim;
    if (((NSNull *)logo == [NSNull null]) || !logo) {
        logo = @"";
    }
    _logo = logo;
}
- (void)setLng:(NSString *)lng
{
    lng = lng.trim;
    if (((NSNull *)lng == [NSNull null]) || !lng) {
        lng = @"";
    }
    _lng = lng;
}
- (void)setLat:(NSString *)lat
{
    lat = lat.trim;
    if (((NSNull *)lat == [NSNull null]) || !lat) {
        lat = @"";
    }
    _lat = lat;
}
- (void)setRange:(NSString *)range
{
    range = range.trim;
    if (((NSNull *)range == [NSNull null]) || !range) {
        range = @"";
    }
    _range = range;
}
- (void)setDesc:(NSString *)desc
{
    desc = desc.trim;
    if (((NSNull *)desc == [NSNull null]) || !desc) {
        desc = @"";
    }
    _desc = desc;
}
- (void)setFavorable:(NSString *)favorable
{
    favorable = favorable.trim;
    if (((NSNull *)favorable == [NSNull null]) || !favorable) {
        favorable = @"";
    }
    _favorable = favorable;
}
- (void)setPhone:(NSString *)phone
{
    phone = phone.trim;
    if (((NSNull *)phone == [NSNull null]) || !phone) {
        phone = @"";
    }
    _phone = phone;
}
- (void)setGoodReptRate:(NSString *)goodReptRate
{
    goodReptRate = goodReptRate.trim;
    if (((NSNull *)goodReptRate == [NSNull null]) || !goodReptRate) {
        goodReptRate = @"";
    }
    _goodReptRate = [goodReptRate stringNumber];
}
- (void)setRecCount:(NSString *)recCount
{
    recCount = recCount.trim;
    if (((NSNull *)recCount == [NSNull null]) || !recCount) {
        recCount = @"";
    }
    _recCount = recCount;
}

@end
