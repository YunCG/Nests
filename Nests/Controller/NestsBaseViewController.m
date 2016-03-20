//
//  NestsBaseViewController.m
//  Nests
//
//  Created by 🐠 on 5/3/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsBaseViewController.h"

static NSString * const sampleDescription1 = @"个人中心菜单加一个动态增加的，根据后台返回标志与名称显示，菜单点进去根据返回的url显示浏览器内容";
static NSString * const sampleDescription2 = @"新增地图离线文件下载和管理";
static NSString * const sampleDescription3 = @"新增清除缓存功能";
static NSString * const sampleDescription4 = @"完成App用户端的所有产品设计";

@interface NestsBaseViewController ()<EAIntroDelegate>
{
   
    EAIntroView *_intro;
}

@end

@implementation NestsBaseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.networkClient =[[ASIHTTPClicent alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // using self.navigationController.view - to display EAIntroView above navigation bar
  
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Navigation
//LeftNavigationBtn
//-(void)setupLeftNavigationBtn
//{
//    self.navigationLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage* backImage =[UIImage imageNamed:@"index_zone_icon"];
//    self.navigationLeftBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
//    [self.navigationLeftBtn setImage:[UIImage imageNamed:@"index_zone_icon"] forState:UIControlStateNormal];
//    [self.navigationLeftBtn setImage:[UIImage imageNamed:@"index_zone_icon_h"] forState:UIControlStateHighlighted];
//    
//    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationLeftBtn];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//}
////RightNavigationBtn
//-(void)setupRightNavigationBtn
//{
//    self.navigationRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage* backImage =[UIImage imageNamed:@"navigation_btn_1.png"];
//    self.navigationRightBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
//    [self.navigationRightBtn setImage:backImage forState:UIControlStateNormal];
//    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationRightBtn];
//    self.navigationItem.rightBarButtonItem = rightItem;
//    
//}

#pragma mark-登录页
-(void)showLoginView
{
    
    BOOL isLogin = [SharedNestsHelper isLoginApp];
    if (!isLogin) {
     
        [self navNestsLoginViewController:NO];
    }

}
#pragma mark-介绍页
- (void)showIntroWithCrossDissolve:(UIView*)rootView
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"积分介绍0";
    page1.desc = sampleDescription1;
    page1.bgImage = [UIImage imageNamed:@"intro_bg_0"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_title_0"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"积分介绍1";
    page2.desc = sampleDescription2;
    page2.bgImage = [UIImage imageNamed:@"intro_bg_1"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_title_1"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"积分介绍2";
    page3.desc = sampleDescription3;
    page3.bgImage = [UIImage imageNamed:@"intro_bg_2"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_title_2"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"积分介绍3";
    page4.desc = sampleDescription4;
    page4.bgImage = [UIImage imageNamed:@"intro_bg_3"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"intro_title_3"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    
    [intro.skipButton  setTitle:@"跳过" forState:UIControlStateNormal];
    [intro showInView:rootView animateDuration:0.3];
}



#pragma mark - EAIntroView delegate

- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"introDidFinish callback");
   
}


///////////////////////////////FAILED///////////////////////
- (void)didFailed:(NSError *)error userInfo:(NSDictionary *)userInfo {
    DDDebug(@"网络失败==%@", error);
    [SVProgressHUD dismiss];
    NSString* messages =APP_NETWORK_DEFAULT_ARRER;
    switch (error.code) {
        case APP_SERVER_ERROR_SEVER_DEFAULT_CODE:
        {
            messages =APP_SERVER_DEFAULT_TIP;
        }
            break;
        case APP_SERVER_ERROR_SEVER_INFO_CODE:
        {
            messages =APP_SERVER_INFO_TIP;
        }
            break;
        case APP_SERVER_ERROR_LOGIN_CODE:
        {
            messages =APP_USER_LOGIN_TIP;
        }
            break;
        case APP_SERVER_CODE:
        {
            messages =error.domain;
        }
            break;
            
        default:
        {
            messages =APP_NETWORK_DEFAULT_ARRER;
        }
            break;
    }
    
    
    
    [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
    
    
    
    
}


-(void)exitAction
{
    DDDLog(@"退出登录");
    
    //登录初始化参数
    [self saveUserDefaultsNotNil:@"" keyValue:APP_LOGIN_TOKEN];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_IMAGE];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_URL];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_TITLE_URL];
    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_PHONE];
    
    [self navNestsLoginViewController:YES];
    
    
}


@end
