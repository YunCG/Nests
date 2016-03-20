//
//  NestsScoreViewController.m
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsScoreViewController.h"
#import "HMSegmentedControl.h"
#import "CornerScoreInfoData.h"
#import "CornerScoreInfoData+Operation.h"
#import "NestsSelectPlan.h"
#import "NestsStyleText_1_TableViewCell.h"

@interface NestsScoreViewController ()<UITableViewDataSource, UITableViewDelegate,NestsSelectPlanDelegae>
@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;
@property(nonatomic,retain) CornerScoreInfoData* dataSource;
@property(nonatomic,retain) NestsSelectPlan*   selectView;
@property(nonatomic,assign) SCORE_TYPE_ID  selectState;

@end

@implementation NestsScoreViewController

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
    
    self.title = @"我的积分";
    
    [self setupNavigaionBar];
    [self setupMainView];
    [self setupMainTableView];
    
    [self selectPlanIndex:100];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self.mainTableView triggerPullToRefresh];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-DataSource
- (void)setupDataSource {
    self.dataSource =[[CornerScoreInfoData alloc] init];
    self.selectState =kSCORE_TYPE_ID_AVIABLE;
}
#pragma mark-setup
-(void)setupNavigaionBar
{
    self.navigationController.navigationBar.translucent = NO;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zone_jifen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backPopViewController:)];
}

-(void)setupMainView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
}


-(void)setupMainTableView
{
    self.mainTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
        CGRect frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 80);
        self.mainTableHeaderView = [[UIView alloc] initWithFrame:frame];
//    [self.mainTableHeaderView showViewBorder:[UIColor redColor] borderWidth:1.0];
        [self.mainTableHeaderView  setBackgroundColor:self.mainTableView.backgroundColor];
    
    
      UIView* topView =[[UIView alloc] initWithFrame:frame];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [self.mainTableHeaderView addSubview:topView];
    
    [self setupHMSegmentedControl:topView];
    
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
        self.mainTableView.tableHeaderView = self.mainTableHeaderView;
    //    self.mainTableView.tableFooterView = self.mainTableFootView;
    
}

- (void)setupHMSegmentedControl:(UIView*)topView
{
    
    self.selectView =[[[NSBundle mainBundle] loadNibNamed:@"NestsSelectPlan" owner:self options:nil] objectAtIndex:0];
    self.selectView.delegate =self;
    [topView addSubview:self.selectView];
  

    [self refreshSelectPlan];
    
}
-(void)refreshSelectPlan
{

   self.selectView.ableScoreLabel.text=   self.dataSource.availableScore;
    self.selectView.consumeLabel.text =   self.dataSource.consumeScore;
    self.selectView.overLabel.text =      self.dataSource.expireScore;

}
#pragma mark-Delegate
-(void)selectPlanIndex:(NSInteger)selectIndex
{
    NSString* flag =@"1";
    switch (selectIndex) {
        case  100:
        {
            DDDLog(@"可用积分");
            flag =@"1";
              self.selectState =kSCORE_TYPE_ID_AVIABLE;
        }
            break;
        case  101:
        {
            DDDLog(@"已消费积分");
            flag =@"2";
              self.selectState =kSCORE_TYPE_ID_CONSUM;
        }
            break;
        case  102:
        {
           DDDLog(@"过期积分");
            flag =@"3";
              self.selectState =kSCORE_TYPE_ID_EXPIRE;
        }
            break;
            
        default:
        {
             flag =@"1";
              self.selectState =kSCORE_TYPE_ID_AVIABLE;
        }
            break;
    }
    
    
    [self netMerScoreID:flag];
    
//    [self.mainTableView  reloadData];
}


#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
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
    
    NSInteger rows =[[self.dataSource arraytableRepresentation]  count];
    
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    NSString *cellName = @"NestsStyleText_1_TableViewCell";
    
    
    NestsStyleText_1_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]
                objectAtIndex:0];
    }
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
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
    
    
    
//    NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:section];
//    NSNumber* isAccessory =infoDic[@"accessory"][row];
//    if (isAccessory.boolValue) {
//        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
//    }
//    
//    cell.textLabel.text =infoDic[@"titles"][row];
//    
//    NSNumber* alignment =infoDic[@"alignment"][row];
//    switch (alignment.intValue) {
//        case 0:
//        {
//            cell.textLabel.textAlignment=NSTextAlignmentLeft;
//        }
//            break;
//        case 1:
//        {
//            cell.textLabel.textAlignment=NSTextAlignmentCenter;
//        }
//            break;
//        case 2:
//        {
//            cell.textLabel.textAlignment=NSTextAlignmentRight;
//        }
//            break;
//            
//        default:
//            break;
//    }
    
     NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:row];
    
    switch (self.selectState) {
        case kSCORE_TYPE_ID_AVIABLE:
        {
           
        }
            break;
        case kSCORE_TYPE_ID_CONSUM:
        {
           
        }
            break;
        case kSCORE_TYPE_ID_EXPIRE:
        {
          
        }
            break;
            
        default:
            break;
    }
    
  
    NSString* name =infoDic[@"name"]?infoDic[@"name"]:@"";
      NSString* logo =infoDic[@"logo"]?infoDic[@"logo"]:@"";
      NSString* created =infoDic[@"created"]?infoDic[@"created"]:@"";//获得积分时间
      NSString* due =infoDic[@"due"]?infoDic[@"due"]:@"";//到期时间
      id score =infoDic[@"score"]?infoDic[@"score"]:@"0";//获得积分
    NSString* scoreStr =[NSString stringWithFormat:@"%@",score];
    
    cell.titleLabel.text =name;
    cell.detailLabel.text =[NSString stringWithFormat:@"赠送时间%@",created];
    cell.timeLabel.text =[NSString stringWithFormat:@"有效期至%@",due];
    cell.scoreLabel.text =[NSString stringWithFormat:@"%@",scoreStr];
    [cell refreshScoreState:self.selectState];
    
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
    __weak NestsScoreViewController *weakSelf = self;
    
    
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
    __weak NestsScoreViewController *weakSelf = self;
    
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
    __weak NestsScoreViewController *weakSelf = self;
    
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
-(void)netMerScoreID:(NSString*)flag
{
    [SVProgressHUD showWithStatus:NESTS_TIP_DEFAULT maskType:SVProgressHUDMaskTypeClear];
    
    int pageSize  =1;
    int pageNum  =10000;
    [self.networkClient netMerScoreID:NET_MER_SCORE_ID flag:flag pageSize:[NSNumber numberWithInt:pageSize] pageNum:[NSNumber numberWithInt:pageNum] delegate:self
                            didFinish:@selector(didNetMerScoreIDFinish:userInfo:)
                            didFailed:@selector(didFailed:userInfo:)
                             userInfo:nil];

    
    
}



- (void)didNetMerScoreIDFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"个人积分请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSDictionary class]]) {
                NSDictionary* infoDic =infoData;
//                NSString* img =infoDic[@"img"];
//                NSString* nickName =[NSString stringWithFormat:@"%@",infoDic[@"nickName"]];
//                self.dataSource.userImage =[SharedNestsHelper imageBaseURL:img];
//                self.dataSource.userName =nickName;
//                
//                self.dataSource.phoneNum =[SharedNestsHelper userPhone];
//                
//                [self.mainTableView reloadData];
                
                
                id num1=infoDic[@"num1"];
                  id num2=infoDic[@"num2"];
                  id num3=infoDic[@"num3"];
                
                id list =infoDic[@"list"];
                
                self.dataSource.availableScore  =[NSString  stringWithFormat:@"%@",num1];
                self.dataSource.consumeScore   =[NSString  stringWithFormat:@"%@",num2];
                self.dataSource.expireScore   =[NSString  stringWithFormat:@"%@",num3];
                
                if ([list  isKindOfClass:[NSArray class]]) {
                    self.dataSource.listArray =[[NSMutableArray alloc] initWithArray:list];
                }
                
                [self refreshSelectPlan];
                  [self.mainTableView reloadData];
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
//            
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
//    [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//    
//    
//    
//    
//}

@end
