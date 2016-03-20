//
//  NestsHomeViewController.m
//  Nests
//
//  Created by 🐠 on 9/12/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsHomeViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "NestsStyleSubtitleTableViewCell.h"
#import "CornerHomeInfoData.h"
#import "CornerHomeInfoData+Operation.h"
#import "NestsBoardViewController.h"


@interface NestsHomeViewController ()
{

    NestsQRViewController* _qrVC;
    NestsListViewController* _listVC;
    NestsMapViewController* _mapVC;
    
    NestsBoardViewController*_boardVC;
    
    UIButton* navigationRightBtn;
}


@property(nonatomic,retain) CornerHomeInfoData* dataSource;
@property(nonatomic,retain) UIViewController* currentViewController;

@end

@implementation NestsHomeViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupDataSource];
        self.contentID =NESTS_CONTENT_ID_DEFAULT;
        self.infoDic =nil;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分";
     [self setupNavigaionBar];
     [self setupMainView];
   
    
    
//   BOOL isFirstLanch = [NestsKit isAppFirstLanch];
//    NSLog(@"第一次启动flag:%i",isFirstLanch);
//    if (isFirstLanch) {
//         [NestsKit saveAppFirstLanch:NO];
//          [self showIntroWithCrossDissolve:rootView];
//    }

    BOOL isLogin = [SharedNestsHelper isLoginApp];
    if (!isLogin) {
        [self  showLoginView];//没登录登录

    }
    
    
      [self performSelector:@selector(initDefault) withObject:nil];
   

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
   
   
}
#pragma mark-DataSource
- (void)setupDataSource {
    self.dataSource =[[CornerHomeInfoData alloc] init];
    
}

-(void)initDefault
{

    //用户默认模式选择
    NSString* selectModel =[self  objectForUserDefaults:APP_USER_SELECT_MODEL];
    DDDLog(@"selectMode===Value==%@",selectModel);
    navigationRightBtn.selected =selectModel.boolValue;
    if (selectModel.boolValue) {
        
        [self hideContentController:_listVC];
        [self hideContentController:_qrVC];
        [self displayContentController:_mapVC];
        
    }
    else
    {
        
      
        [self hideContentController:_mapVC];
        [self hideContentController:_qrVC];
        [self displayContentController:_listVC];
        
        
    }
}

#pragma mark-setup

-(void)setupNavigaionBar
{
     [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"index_zone_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    

    
    
    navigationRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* backImage =[UIImage imageNamed:@"index_list_icon"];
    UIImage* selectImage =[UIImage imageNamed:@"index_map_icon"];
    navigationRightBtn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    [navigationRightBtn setImage:backImage forState:UIControlStateNormal];
    [navigationRightBtn setImage:selectImage forState:UIControlStateSelected];
    [navigationRightBtn  addTarget:self action:@selector(listBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:navigationRightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
 
    
   
}



-(void)listBtnAction:(UIButton*)sender
{
    DDDLog(@"列表模式");
    if (sender.isSelected) {//列表
        [sender  setSelected:NO];
//        [self.view bringSubviewToFront:_lisView];
      
        [self hideContentController:_mapVC];
        [self hideContentController:_qrVC];
        [self displayContentController:_listVC];
        
    }
    else//地图模式
    {
        [sender setSelected:YES];
//         [self.view bringSubviewToFront:_mapView];
        [self hideContentController:_listVC];
        [self hideContentController:_qrVC];
        [self displayContentController:_mapVC];
    }
    
    NSString* selectModel =[NSString stringWithFormat:@"%d",sender.isSelected];
    [self saveUserDefaultsNotNil:selectModel keyValue:APP_USER_SELECT_MODEL];
    
}

-(void)setupMainView
{
    
   self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    [self setupBoardViewController];
    [self setupMapViewController];
     [self setupListViewController];
    [self setupQRViewController];
    
   
    
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"NestsResideMenuFirstViewController will appear");
    [self dispatch:self.contentID info:self.infoDic];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"NestsHomeViewController will disappear");
}
#pragma mark-BoardView
-(void)boardHomeBtnAction:(UIButton*)btn
{
//    navigationRightBtn.selected =selectModel.boolValue;
//     DDDLog(@"home touch");
//    [self hideContentController:_mapVC];
//    [self hideContentController:_qrVC];
//    [self displayContentController:_listVC];
     self.title =@"积分";
      [navigationRightBtn  setHidden:NO];
    navigationRightBtn.selected =!navigationRightBtn.selected;
    [self listBtnAction:navigationRightBtn];
}
-(void)boardQCBtnAction:(UIButton*)btn
{

    [navigationRightBtn  setHidden:YES];
    self.title =@"我的二维码";
   
    DDDLog(@"QC touch");
   
    [self hideContentController:_mapVC];
    [self hideContentController:_listVC];
    [self displayContentController:_qrVC];
    
    
   
    
//     [self navNestsQRViewController];
}



#pragma mark-setupSubViewController
-(void)setupBoardViewController
{
    
    _boardVC =[[NestsBoardViewController alloc] init];
    [self addChildViewController:_boardVC];
    
    NestsBoardView*  tipView =(NestsBoardView*)_boardVC.view;
    [tipView setCenter:CGPointMake(CGRectGetWidth(self.view.frame)*0.5, CGRectGetHeight(self.view.frame)-CGRectGetHeight(tipView.frame)*2)];
      tipView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    
    [tipView.btnHome  addTarget:self action:@selector(boardHomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
       [tipView.btnQC  addTarget:self action:@selector(boardQCBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tipView];
   
}
-(void)setupQRViewController
{
    
    _qrVC =[SharedNestsSceneDispatch nestsQRViewController];
  
    
}
-(void)setupListViewController
{
    
    _listVC =[SharedNestsSceneDispatch nestsListViewController];
}

-(void)setupMapViewController
{
    
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"方恒国际";
//    pointAnnotation.subtitle = @"阜通东大街6号";

    
    _mapVC =[SharedNestsSceneDispatch nestsMapViewController:YES isShowNearby:YES desPoint:nil  annotaitonArray:nil];
      [_mapVC.navigationController  setHidesBottomBarWhenPushed:YES];
}




#pragma mark-Add ChildViewController
- (void) displayContentController: (UIViewController*) content;

{
    
    [self addChildViewController:content];                 // 1
    
    self.currentViewController =content;
//    [self.view addSubview:self.currentViewController.view];
    [self.view insertSubview:self.currentViewController.view belowSubview:_boardVC.view];
    
    [content didMoveToParentViewController:self];          // 3
    
}


- (void) hideContentController: (UIViewController*) content

{
    
    [content willMoveToParentViewController:nil];  // 1
    
    [content.view removeFromSuperview];            // 2
    
    [content removeFromParentViewController];      // 3
    
}

#pragma mark-跳转
-(void)dispatch:(NESTS_CONTENT_ID)contentID
           info:(id)info
{
    switch (contentID) {
        case NESTS_CONTENT_ID_SCORE:
        {
            
              self.contentID =NESTS_CONTENT_ID_DEFAULT;
            [self navNestsScoreViewController];
          
          
            
            
        }
            break;
        case NESTS_CONTENT_ID_EVALUATE:
        {
               self.contentID =NESTS_CONTENT_ID_DEFAULT;
             [self navNestsEvaluateViewController];
         
           
           
        }
            break;
        case NESTS_CONTENT_ID_MESSAGE:
        {
            self.contentID =NESTS_CONTENT_ID_DEFAULT;
            [self navNestsMessageViewController];
            
            
        }
            break;
        case NESTS_CONTENT_ID_WEB:
        {
          
              self.contentID =NESTS_CONTENT_ID_DEFAULT;
            if ([info isKindOfClass:[NSDictionary class]]) {
                  [self navNestsWebViewController:info];
                
            }
            
          
        }
            break;
        case NESTS_CONTENT_ID_PERSONINFO:
        {
            
            self.contentID =NESTS_CONTENT_ID_DEFAULT;
//            if ([info isKindOfClass:[NSDictionary class]]) {
                [self navNestsPersonInfoViewController];
                
//            }
            
            
        }
            break;
            
            
        case NESTS_CONTENT_ID_MORE:
        {
            self.contentID =NESTS_CONTENT_ID_DEFAULT;
            [self navNestsSettingViewController];
        }
            break;
            
        default:
            break;
    }
}
@end
