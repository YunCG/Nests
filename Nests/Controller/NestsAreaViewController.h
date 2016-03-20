//
//  NestsAreaViewController.h
//  Nests
//
//  Created by 🐠 on 12/26/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController.h"
@protocol NestsAreaViewControllerDelegate <NSObject>

-(void)selectAddress:(NSDictionary*)addrDic;

@end
@interface NestsAreaViewController : NestsBaseViewController
@property(assign,nonatomic) id delegate;
@end
