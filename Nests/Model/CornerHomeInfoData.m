//
//  CornerHomeInfoData.m
//  Nests
//
//  Created by 🐠 on 11/8/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "CornerHomeInfoData.h"

@implementation CornerHomeInfoData
- (id)init {
    self = [super init];
    if (self) {
        
        self.listArray =[[NSMutableArray alloc] initWithCapacity:1];
        self.count =0;
        
        self.shopingName =@"";
        self.shopingRegion =@"";
        self.shopingRegion2 =@"";
         self.shopingRegion3 =@"";
    }
    return self;
}


- (void)setShopingName:(NSString *)shopingName
{
    shopingName = shopingName.trim;
    if (((NSNull *)shopingName == [NSNull null]) || !shopingName) {
        shopingName = @"";
    }
    _shopingName = shopingName;
}

- (void)setShopingRegion:(NSString *)shopingRegion
{
    shopingRegion = shopingRegion.trim;
    if (((NSNull *)shopingRegion == [NSNull null]) || !shopingRegion) {
        shopingRegion = @"";
    }
    _shopingRegion = shopingRegion;
}

- (void)setShopingRegion2:(NSString *)shopingRegion2
{
    shopingRegion2 = shopingRegion2.trim;
    if (((NSNull *)shopingRegion2 == [NSNull null]) || !shopingRegion2) {
        shopingRegion2 = @"";
    }
    _shopingRegion2 = shopingRegion2;
}
- (void)setShopingRegion3:(NSString *)shopingRegion3
{
    shopingRegion3 = shopingRegion3.trim;
    if (((NSNull *)shopingRegion3 == [NSNull null]) || !shopingRegion3) {
        shopingRegion3 = @"";
    }
    _shopingRegion3 = shopingRegion3;
}
@end
