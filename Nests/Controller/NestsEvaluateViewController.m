//
//  NestsEvaluateViewController.m
//  Nests
//
//  Created by 🐠 on 9/12/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsEvaluateViewController.h"
#import "HMSegmentedControl.h"
#import "CornerEvaluateInfoData.h"
#import "CornerEvaluateInfoData+Operation.h"
#import "NestsStyleSubtitle_0_TableViewCell.h"



@interface NestsEvaluateViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    EvaluateID evaluateState;
}
@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;
@property(nonatomic,retain) CornerEvaluateInfoData* dataSource;

@end

@implementation NestsEvaluateViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupDataSource];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的评价";
    
    [self setupNavigaionBar];
    [self setupMainView];
    
    [self netMerEvaluateMine:EvaluateID_Will];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self.mainTableView triggerPullToRefresh];
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
#pragma mark-DataSource
- (void)setupDataSource {
    self.dataSource =[[CornerEvaluateInfoData alloc] init];
    evaluateState =EvaluateID_Will;
}

#pragma mark-setup
-(void)setupNavigaionBar
{
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zone_jifen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backPopViewController:)];
    

}

-(void)setupMainView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    [self setupHMSegmentedControl];
    [self setupMainTableView];
}


- (void)setupHMSegmentedControl
{
    
//    CGFloat tabBarHeight =CGRectGetHeight(self.rdv_tabBarController.tabBar.frame);
//    CGFloat statusHeight =self.navigationController.navigationBar.frame.origin.y;
//    CGFloat navgationBarHeight =CGRectGetHeight(self.navigationController.navigationBar.frame);
//    //    CGFloat viewHeight =CGRectGetHeight(self.view.frame)-tabBarHeight-navgationBarHeight-statusHeight;
//    CGFloat view_Y =navgationBarHeight;
    
    
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"待评价", @"已评价"]];
    segmentedControl.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50);
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    [segmentedControl setBackgroundColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    segmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl.selectionIndicatorColor = [UIColor darkGrayColor];
    segmentedControl.selectionIndicatorHeight =2.0f;
    segmentedControl.selectionIndicatorBoxOpacity =0.5;
    segmentedControl.verticalDividerEnabled = YES;
    segmentedControl.verticalDividerColor = [UIColor clearColor];
    segmentedControl.verticalDividerWidth = 1.0f;
    [segmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor],
                                                                                                      NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        if (selected) {
            attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                                                      NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        }
        
        return attString;
    }];
    
//    [self.view addSubview:segmentedControl];
    
//    UIView *subSuperview = self.view;
//    UIEdgeInsets padding2 = UIEdgeInsetsMake(0, 0, 0, 0);
//    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(subSuperview.mas_top)
//        .with.offset(padding2.top);  // with is an optional semantic filler
//        make.left.equalTo(subSuperview.mas_left).with.offset(padding2.left);
//        make.right.equalTo(subSuperview.mas_right).with.offset(-padding2.right);
//        make.height.equalTo(@TOP_SEGMENT);
//        
//    }];
    
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
  
        switch (segmentedControl.selectedSegmentIndex) {
            case 0:
            {
                DDDebug(@"呆评价");
                 evaluateState =EvaluateID_Will;
                
            
                
            }
                break;
            case 1:
            {
                DDDebug(@"已评价");
                 evaluateState =EvaluateID_Over;
             
            }
                break;
                
            default:
                break;
        }
        
    
    [self netMerEvaluateMine:evaluateState];
    [self.mainTableView reloadData];
    
}


-(void)setupMainTableView
{
    self.mainTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50 , self.view.frame.size.width, self.view.frame.size.height-50) style:UITableViewStyleGrouped];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //         tableView.separatorInset = UIEdgeInsetsZero;//分割线到头
        tableView.bounces = YES;
        tableView;
    });
    
    //    [self.mainTableView showViewBorder:[UIColor greenColor] borderWidth:1.0];
    [self.view addSubview:self.mainTableView];
    
    //上拉刷新
    //    [self setupSVPullToRefresh];
    
    
    
    //    //HeaderView
    //    CGRect frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 50);
    //    self.mainTableHeaderView = [[UIView alloc] initWithFrame:frame];
    //    [self.mainTableHeaderView  setBackgroundColor:self.mainTableView.backgroundColor];
    //    //FootView
    //    CGRect footFrame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 180);
    //    self.mainTableFootView = [[UIView alloc] initWithFrame:footFrame];
    //    [self.mainTableFootView  setBackgroundColor:self.mainTableView.backgroundColor];
    //
    //    CGFloat  btnWidth =300;
    //    CGFloat start_x =(CGRectGetWidth(self.view.frame)-btnWidth)*0.5;
    //
    //    BButton* btnExit =[[BButton alloc] initWithFrame:CGRectMake(start_x, 20.0f, btnWidth, 40.0f) color:[UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0] style:BButtonStyleBootstrapV3];
    //    [btnExit  setTitle:@"退出登录" forState:UIControlStateNormal];
    ////    [btnExit addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    BButton* btnReset =[[BButton alloc] initWithFrame:CGRectMake(start_x, 70.0f, btnWidth, 40.0f) color:[UIColor colorWithRed:0.0 green:0.74 blue:0.30 alpha:1.0] style:BButtonStyleBootstrapV3];
    //  [btnReset  setTitle:@"重置密码" forState:UIControlStateNormal];
    //
    ////    [btnReset addTarget:self action:@selector(resetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.mainTableFootView addSubview:btnReset];
    //    [self.mainTableFootView addSubview:btnExit];
    //
    //     [self.mainTableHeaderView showViewBorder:[UIColor redColor] borderWidth:1.0];
    //    [self.mainTableFootView showViewBorder:[UIColor redColor] borderWidth:1.0];
    //
    //    self.mainTableView.tableHeaderView = self.mainTableHeaderView;
    //    self.mainTableView.tableFooterView = self.mainTableFootView;
    
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    NSDictionary* infoDic =self.dataSource.listArray[row];
    
    switch (evaluateState) {
        case EvaluateID_Will:
        {
            
            
            [self navNestsEvaluateBIZViewController:infoDic];
        }
            break;
        case EvaluateID_Over:
        {
            [self navNestsEvaluateDetailViewController:infoDic];
//            NSDictionary* detailInfoDic =@{
//                                           SHOPING_ID : @"M111111",
//                                           };
//            [self navNestsShopingAppraiseViewController:detailInfoDic];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    float height = cell.frame.size.height;
    
    return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger sections =1;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    NSInteger rows =0;
    
    rows =[[self.dataSource arraytableRepresentation:evaluateState]  count];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    NSString *cellName = @"NestsStyleSubtitle_0_TableViewCell";
    
    switch (evaluateState) {
        case EvaluateID_Will:
        {
           cellName = @"NestsStyleSubtitle_0_TableViewCell";
        }
            break;
        case EvaluateID_Over:
        {
            cellName = @"NestsStyleSubtitle_0_0_TableViewCell";
        }
            break;
            
        default:
        {
           cellName = @"NestsStyleSubtitle_0_TableViewCell";
        }
            break;
    }
    
    NestsStyleSubtitle_0_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]
                objectAtIndex:0];
    }

    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.backgroundColor = [UIColor whiteColor];
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        cell.textLabel.textColor = [UIColor darkGrayColor];
//        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
//        //        cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
//        //        [cell setSeparatorInset:UIEdgeInsetsZero];//cell分割线
//        //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//        
//    }
    
  
//    NSNumber* isAccessory =infoDic[@"accessory"][row];
//    if (isAccessory.boolValue) {
//        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
//    }
    
    
    switch (evaluateState) {
        case EvaluateID_Will:
        {
             cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case EvaluateID_Over:
        {
           cell.accessoryType =UITableViewCellAccessoryNone;
        }
            break;
            
        default:
        {
            cell.accessoryType =UITableViewCellAccessoryNone;
        }
            break;
    }

  
    NSArray* infoArray=[self.dataSource arraytableRepresentation:evaluateState];
    NSDictionary* infoDic =infoArray[row];
    
    id name =infoDic[@"name"]?infoDic[@"name"]:@"";
     id logo =infoDic[@"logo"]?infoDic[@"logo"]:@"";
    id amt =infoDic[@"amt"]?infoDic[@"amt"]:@"";
     id score =infoDic[@"score"];
    id addr =infoDic[@"addr"]?infoDic[@"addr"]:@"";
    
    
    
   cell.titleLabel.text =[NSString stringWithFormat:@"%@",name];
    cell.subTitleLabel.text  =[NSString stringWithFormat:@"消费 %@",amt];
    cell.subIcon.image =[UIImage imageNamed:@"zone_pj_rmb"];
    NSString* imageUrl =[NSString stringWithFormat:@"%@",logo];
    NSString* imageStr =[SharedNestsHelper imageBaseURL:imageUrl];
    [cell.cellImage  sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
    NSNumber* evalueValue =[NSNumber numberWithInt:5];
    if ([score  isKindOfClass:[NSNumber class]]) {
        evalueValue =score;
    }

    cell.starRatingView.value =evalueValue.floatValue;
    cell.starRatingView.enabled=NO;
    
    //line
    UIView* line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.bounds), CGRectGetWidth(cell.bounds), 1)];
    [line setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
    [cell addSubview:line];
    
    return cell;
}

#pragma mark-TableVeiwHeader&Bottom
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;//section头部高度
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark-SVPullToRefresh

-(void)setupSVPullToRefresh
{
    __weak NestsEvaluateViewController *weakSelf = self;
    
    
    // setup pull-to-refresh
    [self.mainTableView addPullToRefreshWithActionHandler:^{
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateTriggered];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"加载中。。。。" forState:SVPullToRefreshStateLoading];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
        //        weakSelf.mainTableView.pullToRefreshView.arrowColor =[UIColor redColor];
        weakSelf.mainTableView.indicatorStyle  =UIActivityIndicatorViewStyleWhiteLarge;
        [weakSelf insertRowAtTop];
    }];
    
    // 上拉刷新
    [self.mainTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateTriggered];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"加载中。。。。" forState:SVPullToRefreshStateLoading];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
        //        weakSelf.mainTableView.pullToRefreshView.arrowColor =[UIColor redColor];
        weakSelf.mainTableView.indicatorStyle  =UIActivityIndicatorViewStyleWhite;
        [weakSelf insertRowAtBottom];
    }];
    
}




- (void)insertRowAtTop {
    __weak NestsEvaluateViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.mainTableView beginUpdates];
        //        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
        //        [weakSelf.mainTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.mainTableView endUpdates];
        
        [weakSelf.mainTableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    __weak NestsEvaluateViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.mainTableView beginUpdates];
        //        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
        //        [weakSelf.mainTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [weakSelf.mainTableView endUpdates];
        
        [weakSelf.mainTableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark-Network
-(void)netMerEvaluateMine:(EvaluateID)state//积分标志(1、待评价 2、已评价 )
{
    //       [self.networkClient netSecurityCode:NET_USER_SECURITY_ID
    //                               delegate:self
    //                              didFinish:@selector(didNetSecurityCodeFinish:userInfo:)
    //                              didFailed:@selector(didNetSecurityCodeFailed:userInfo:)
    //                               userInfo:nil];
    
    NSString* flat =@"1";
    
    switch (state) {
        case EvaluateID_Will:
        {
            flat =@"1";
        }
            break;
        case EvaluateID_Over:
        {
            flat =@"2";
        }
            break;
            
        default:
            break;
    }
    
    int pageSize  =1;
    int pageNum  =10000;
    
    [self.networkClient netMerEvaluateMine:NET_MER_EVALUATE_MINE_ID flag:flat pageSize:[NSNumber numberWithInt:pageSize] pageNum:[NSNumber numberWithInt:pageNum] delegate:self
      didFinish:@selector(didNetMerEvaluateMineFinish:userInfo:)
                                 didFailed:@selector(didFailed:userInfo:)
                                  userInfo:nil];
    
    
    
    
    
}

- (void)didNetMerEvaluateMineFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
//    NSString* responseStrLocal = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"score_str" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    

    
    NSDictionary* resultDic =[result stringJsonValue];
    
//     NSDictionary* resultDic =[responseStrLocal stringJsonValue];
    
    DDDebug(@"我的评价请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSDictionary class]]) {
                NSDictionary* infoDic =infoData;
                NSArray* list =infoDic[@"list"];
                
               
                
                if ([list  isKindOfClass:[NSArray class]]) {
                    [self.dataSource.listArray  removeAllObjects];
                    self.dataSource.listArray =[[NSMutableArray alloc] initWithArray:list];
                    [self.mainTableView reloadData];
                    
                }
            }
            
            
            
            
        }
        else
        {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSString class]]) {
                
                NSString* messages =infoData;
                NSError* error =[[NSError alloc] initWithDomain:messages code:APP_SERVER_CODE userInfo:nil];
                [self didFailed:error userInfo:nil];
                
            }
            
            
        }
    }
    else
    {
        NSError* error =[[NSError alloc] initWithDomain:APP_SERVER_DEFAULT_TIP code:APP_SERVER_ERROR_SEVER_DEFAULT_CODE userInfo:nil];
        [self didFailed:error userInfo:nil];
    }
    
    
    
}
///////////////////////////////FAILED///////////////////////
//- (void)didFailed:(NSError *)error userInfo:(NSDictionary *)userInfo {
//    DDDebug(@"网络失败==%@", error);
//    [SVProgressHUD dismiss];
//    NSString* messages =APP_NETWORK_DEFAULT_ARRER;
//    switch (error.code) {
//        case APP_SERVER_ERROR_SEVER_DEFAULT_CODE:
//        {
//            messages =APP_SERVER_DEFAULT_TIP;
//        }
//            break;
//        case APP_SERVER_ERROR_SEVER_INFO_CODE:
//        {
//            messages =APP_SERVER_INFO_TIP;
//        }
//            break;
//        case APP_SERVER_ERROR_LOGIN_CODE:
//        {
//            messages =APP_USER_LOGIN_TIP;
//        }
//            break;
//        case APP_SERVER_CODE:
//        {
//            messages =error.domain;
//        }
//            break;
//   
//        default:
//        {
//            messages =APP_NETWORK_DEFAULT_ARRER;
//        }
//            break;
//    }
//    
//    
// 
//        
//            [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
//             {
//             
//                 [self navNestsLoginViewController:YES];
//                 
//             }];
//   
//    
//}

@end
