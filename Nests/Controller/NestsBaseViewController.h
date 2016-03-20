//
//  NestsBaseViewController.h
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPClicent.h"
#import "EAIntroView.h"
#import "NestsBoardView.h"
#import "NestsAMapKit.h"
@interface NestsBaseViewController : UIViewController
@property(nonatomic,retain) UIButton* navigationLeftBtn;
@property(nonatomic,retain) UIButton* navigationRightBtn;
@property(nonatomic,retain)ASIHTTPClicent* networkClient;





//@property(nonatomic,retain)NestsBoardView* boardView;

////LeftNavigationBtn
//-(void)setupLeftNavigationBtn;
////RightNavigationBtn
//-(void)setupRightNavigationBtn;
#pragma mark-介绍页
- (void)showIntroWithCrossDissolve:(UIView*)rootView;
- (void)introDidFinish:(EAIntroView *)introView ;
#pragma mark-登录页
-(void)showLoginView;

//#pragma mark-NestsBoardView
//-(void)showBoardView:(UIView*)topView;
////Board Action
//-(void)boardHomeBtnAction:(UIButton*)btn;
//-(void)boardQCBtnAction:(UIButton*)btn;

- (void)didFailed:(NSError *)error userInfo:(NSDictionary *)userInfo ;
-(void)exitAction;

@end
