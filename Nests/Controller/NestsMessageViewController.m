//
//  NestsMessageViewController.m
//  Nests
//
//  Created by 🐠 on 9/12/15.
//  Copyright (c) 2015 Daisy. All rights reserved.
//

#import "NestsMessageViewController.h"
#import "CornerMessagesInfoData.h"
#import "CornerMessagesInfoData+Operation.h"

@interface NestsMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;
@property(nonatomic,retain) CornerMessagesInfoData* dataSource;

@end

@implementation NestsMessageViewController
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
    
    self.title = @"我的消息";
    
    [self setupNavigaionBar];
    [self setupMainView];
    [self setupMainTableView];
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
    self.dataSource =[[CornerMessagesInfoData alloc] init];
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
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        tableView.separatorInset = UIEdgeInsetsZero;//分割线到头
        tableView.bounces = YES;
        tableView;
    });
    
    //    [self.mainTableView showViewBorder:[UIColor greenColor] borderWidth:1.0];
    [self.view addSubview:self.mainTableView];
    
    //上拉刷新
    [self setupSVPullToRefresh];
    
    
    
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
    
    
     NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:row];
    
    NSNumber* isRead =infoDic[@"isRead"];
    NSString* messageID =infoDic[@"id"];
    if (!isRead.boolValue) {
        [SharedNestsSQLite readRemoteMessage:messageID isRead:YES];
        
    }
   
    
    NSString* messages =infoDic[@"messages"];
    NSString* infoMessages =@"";
    NSDictionary* resultDic =[messages stringJsonValue];
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSString* msgId =resultDic[@"msgId"];
        if ([msgId isKindOfClass:[NSString class]]&&![msgId.trim isEqualToString:@""]) {
            NSDictionary* apsDic =resultDic[@"aps"];
            NSString* title =apsDic[@"alert"];
            NSString* link=[NSString stringWithFormat:@"%@/%@/index.bd",NET_WEB_BASE_URL,msgId];
            
            NSDictionary* infoDic =@{NESTS_WEB_TITLE:title,
                                     NESTS_WEB_LINK:link,
                                     NESTS_WEB_POP_TYPE:[NSNumber numberWithInt:WebPopTypeID_Default]};
            
            [self navNestsWebViewController:infoDic];
        }
            }
    

    [self.mainTableView reloadData];
}
#pragma mark-UITableView删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
  
    NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:row];
    
    NSString* id =infoDic[@"id"];
    
    [SharedNestsSQLite deleteRemoteMessage:id];
    
    
      [self.mainTableView reloadData];
    
}
#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        //        cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
        cell.detailTextLabel.textColor = [UIColor grayColor];
        
    }
    
    NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:row];
    
   
    NSString* messages =infoDic[@"messages"];
    NSString* infoMessages =@"";
        NSDictionary* resultDic =[messages stringJsonValue];
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSDictionary* apsDic =resultDic[@"aps"];
        NSString* alert =apsDic[@"alert"];
        
        infoMessages =alert;
    }
   
    
    
    
    cell.textLabel.text =infoMessages;
    cell.detailTextLabel.text =infoDic[@"createdTime"];
    
   
   
    NSNumber* isRead =infoDic[@"isRead"];
    if (isRead.boolValue) {
        
        UIImage* icon =[UIImage createColorEllipseImg:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0] rect:CGRectMake(0, 0, 10.0, 10)];
        cell.imageView.image =icon;
    }
    else
    {
        UIImage* icon =[UIImage createColorEllipseImg:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0] rect:CGRectMake(0, 0, 10.0, 10)];
        cell.imageView.image =icon;
   
    }
    
    
   
    
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
    __weak NestsMessageViewController *weakSelf = self;
    
    
    // setup pull-to-refresh
    [self.mainTableView addPullToRefreshWithActionHandler:^{
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateTriggered];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"加载中。。。。" forState:SVPullToRefreshStateLoading];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
        //        weakSelf.mainTableView.pullToRefreshView.arrowColor =[UIColor redColor];
        weakSelf.mainTableView.indicatorStyle  =UIActivityIndicatorViewStyleWhite;
        [weakSelf insertRowAtTop];
        
        
         [weakSelf  performSelector:@selector(refreshMessages)];
    }];
    
    // 上拉刷新
//        [self.mainTableView addInfiniteScrollingWithActionHandler:^{
//            [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateTriggered];
//            [weakSelf.mainTableView.pullToRefreshView  setTitle:@"加载中。。。。" forState:SVPullToRefreshStateLoading];
//            [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
//            //        weakSelf.mainTableView.pullToRefreshView.arrowColor =[UIColor redColor];
//            weakSelf.mainTableView.indicatorStyle  =UIActivityIndicatorViewStyleWhite;
//            [weakSelf insertRowAtBottom];
//        }];
    
}




- (void)insertRowAtTop {
    __weak NestsMessageViewController *weakSelf = self;
    
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
    __weak NestsMessageViewController *weakSelf = self;
    
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

#pragma mark-refreshMessage
-(void)refreshMessages
{
    [self.mainTableView reloadData];
}
@end
