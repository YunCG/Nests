//
//  NestsParallaxViewController.m
//  Nests
//
//  Created by 🐠 on 11/28/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsParallaxViewController.h"
#import "NestsParallaxHeaderView.h"
#import "CornerParallaxInfoData.h"
#import "CornerParallaxInfoData+Operation.h"
#import "NestsMMScrollPresenter.h"



@interface NestsParallaxViewController () <UITableViewDataSource, UITableViewDelegate,StarRatingDelegate>
@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;
@property(nonatomic,retain) CornerParallaxInfoData* dataSource;
@property (retain, nonatomic) NestsMMScrollPresenter *nestsMMScrollPresenter;
@property(nonatomic,retain) NSMutableArray  *shopingInfoArray;


@end

@implementation NestsParallaxViewController
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
    [self setupNavigaionBar];
    [self setupMainView];
      [self setupMainTableView];
    
    [self performSelector:@selector(netMerShopingkepperInfo)];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
}
- (void)viewDidAppear:(BOOL)animated
{
     if ([self.mainTableView.tableHeaderView isKindOfClass:[NestsParallaxHeaderView class]]) {
    //头部模糊效果
    [(NestsParallaxHeaderView *)self.mainTableView.tableHeaderView refreshBlurViewForNewImage];
     }
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
    self.dataSource =[[CornerParallaxInfoData alloc] init];
    self.shopingInfoArray =[[NSMutableArray alloc] initWithCapacity:1];
}
#pragma mark-setup
-(void)setupNavigaionBar
{
    self.navigationController.navigationBar.translucent = YES;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
  
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zone_jifen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backPopViewController:)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}

-(void)setupMainView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    //调整UITableViews 高度
    self.automaticallyAdjustsScrollViewInsets =NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack]; 
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
        //         tableView.separatorInset = UIEdgeInsetsZero;//分割线到头
        tableView.bounces = YES;
        tableView;
    });
    
    //    [self.mainTableView showViewBorder:[UIColor greenColor] borderWidth:1.0];
    [self.view addSubview:self.mainTableView];
    
    //上拉刷新
    //    [self setupSVPullToRefresh];
    
    
    
    //    //HeaderView

//    self.mainTableHeaderView =   [NestsParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"HeaderImage"] forSize:CGSizeMake(self.mainTableView.frame.size.width, 300)];
//    self.mainTableHeaderView.headerTitleLabel.text = @"TEst";
    
    UIView* parallaxSubView =[self setupNestsMMScrollPresenter];
    
    
        self.mainTableHeaderView =   [NestsParallaxHeaderView parallaxHeaderViewWithSubView:parallaxSubView];
    
//    self.mainTableHeaderView = parallaxSubView;


        [self.mainTableHeaderView  setBackgroundColor:[UIColor clearColor]];
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

-(UIView*)setupNestsMMScrollPresenter
{
      UIView* bgView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainTableView.frame.size.width, 300)];
    self.nestsMMScrollPresenter =[[NestsMMScrollPresenter alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bgView.frame), CGRectGetHeight(bgView.frame))];
    
//    [bgView addSubview:self.nestsMMScrollPresenter];
    
    UIImageView *mountainImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mountains.jpg"]];
    [mountainImage setFrame:CGRectMake(0, 0, self.nestsMMScrollPresenter.frame.size.width, self.nestsMMScrollPresenter.frame.size.height)];
    
    UIImageView *dockImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dock.jpg"]];
    [dockImage setFrame:CGRectMake(0, 0, self.nestsMMScrollPresenter.frame.size.width, self.nestsMMScrollPresenter.frame.size.height)];
    
    UIImageView *forestImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forest.jpg"]];
    [forestImage setFrame:CGRectMake(0, 0, self.nestsMMScrollPresenter.frame.size.width, self.nestsMMScrollPresenter.frame.size.height)];
    
    UIImageView *forestImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"forest.jpg"]];
    [forestImage2 setFrame:CGRectMake(0, 0, self.nestsMMScrollPresenter.frame.size.width, self.nestsMMScrollPresenter.frame.size.height)];
    
    
    NestsMMScrollPage* firstPage = [[NestsMMScrollPage alloc] init];
    firstPage.titleLabel.text = @"";
    firstPage.detailLabel.text = @"";
    [firstPage.backgroundView addSubview:mountainImage];
     firstPage.titleBackgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
//    NestsMMScrollPage *secondPage = [[NestsMMScrollPage alloc] init];
//    secondPage.titleLabel.text = @"";
//    secondPage.detailLabel.text = @"本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍";
//    [secondPage.backgroundView addSubview:dockImage];
//    secondPage.titleBackgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
//    
//    NestsMMScrollPage *thirdPage = [[NestsMMScrollPage alloc] init];
//    thirdPage.titleLabel.text = @"";
//    thirdPage.detailLabel.text = @"本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍";
//    [thirdPage.backgroundView addSubview:forestImage];
//    thirdPage.titleBackgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
//    
//    NestsMMScrollPage *fourthPage = [[NestsMMScrollPage alloc] init];
//    fourthPage.titleLabel.text = @"";
//    fourthPage.detailLabel.text = @"本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍本店介绍";
//    [fourthPage.backgroundView addSubview:forestImage2];
//    fourthPage.titleBackgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    
    
//    [self.nestsMMScrollPresenter addMMScrollPageArray:@[firstPage, secondPage, thirdPage, fourthPage]];
    
    [self.shopingInfoArray addObject:firstPage];
        [self.nestsMMScrollPresenter addMMScrollPageArray:self.shopingInfoArray];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    return self.nestsMMScrollPresenter;
}
#pragma mark-状态栏
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark-NestsParallaxHeaderViewDelegate
#pragma mark -
#pragma mark UISCrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.mainTableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        if ([self.mainTableView.tableHeaderView isKindOfClass:[NestsParallaxHeaderView class]]) {
             [(NestsParallaxHeaderView *)self.mainTableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
            
        }
       
        
       
    }
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
       NSDictionary* indexDic=[[self.dataSource arraytableRepresentation] objectAtIndex:section];
    NSString *identifier =indexDic[@"identifier"][row];
    if ([identifier  isEqualToString:kNestsStylePattern_1_TableViewCell]) {
        NSString* lat =self.dataSource.lat;
        NSString* lon =self.dataSource.lng;
       
            CLLocationCoordinate2D pointCoordinate=CLLocationCoordinate2DMake(lat.floatValue,lon.floatValue);
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = pointCoordinate;
        pointAnnotation.title = self.dataSource.name;
        pointAnnotation.subtitle = self.dataSource.addr;
        
        [self navNestsMapViewController:NO isShowNearby:NO desPoint:pointAnnotation annotaitonArray:nil];


        
    }
    else
    {
       //测试
//        [self navNestsShopingAppraiseViewController:infoDic];
        NSDictionary* detailInfoDic =@{
                                       SHOPING_ID : @"M111111",
                                       };
        [self navNestsShopingAppraiseViewController:detailInfoDic];
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
    
    NSInteger sections =[[self.dataSource arraytableRepresentation]  count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    NSInteger rows =0;
    if (sectionIndex<[[self.dataSource arraytableRepresentation]  count]) {
        NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:sectionIndex];
       
         NSNumber* rowValue =infoDic[@"rows"];
        rows =rowValue.intValue;
    }
 
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"DefaultCell";
    
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    
    NSDictionary* indexDic=[[self.dataSource arraytableRepresentation] objectAtIndex:section];
    
    
    NSString *identifier =indexDic[@"identifier"][row];
    UITableViewCell *cell =nil;
    
    if ([identifier  isEqualToString:kNestsDefault_TableViewCell]) {
         cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
    }
    else
    {
       cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
  
    
  
    if (cell == nil) {
        
        if ([identifier  isEqualToString:kNestsDefault_TableViewCell]) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [UIColor darkGrayColor];
            cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
            //        cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
            //        [cell setSeparatorInset:UIEdgeInsetsZero];//cell分割线
            //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        else
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil]
                    objectAtIndex:0];
            
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
      
    }
    
    NSDictionary* infoDic =indexDic[identifier];
    
    if ([identifier  isEqualToString:kNestsParallax_0_TableViewCell]) {
        NestsParallax_0_TableViewCell* infoCell =(NestsParallax_0_TableViewCell*)cell;
        [infoCell.starRatingView setEnabled:NO];
        infoCell.titleLabel.text =infoDic[@"titles"];
        NSNumber* evalueValue =infoDic[@"evalueValues"];
        infoCell.starRatingView.value =evalueValue.floatValue;
        infoCell.delegate =self;
        
        
    }
    else if ([identifier  isEqualToString:kNestsParallax_1_TableViewCell])
    {
        NestsParallax_1_TableViewCell* infoCell =(NestsParallax_1_TableViewCell*)cell;
        infoCell.titleLabel.text =infoDic[@"titles"];
        
    }
    else if ([identifier  isEqualToString:kNestsStylePattern_0_TableViewCell])
    {
        NestsStylePattern_0_TableViewCell* infoCell =(NestsStylePattern_0_TableViewCell*)cell;
        infoCell.describeLabel.text =infoDic[@"describe"];
    }
    else if ([identifier  isEqualToString:kNestsStylePattern_1_TableViewCell])
    {
        NestsStylePattern_1_TableViewCell* infoCell =(NestsStylePattern_1_TableViewCell*)cell;
        infoCell.titleLabel.text =infoDic[@"titles"];
        NSString* imageIcon =infoDic[@"icons"];
        infoCell.icon.image =[UIImage imageNamed:imageIcon];
    }
    else if ([identifier  isEqualToString:kNestsStylePattern_2_TableViewCell])
    {
        NestsStylePattern_2_TableViewCell* infoCell =(NestsStylePattern_2_TableViewCell*)cell;
          NSString* btnTitles =infoDic[@"btnTitles"];
        NSString* btnImage =infoDic[@"btnImage"];
        [infoCell.cellBtn setTitle:btnTitles forState:UIControlStateNormal];
         [infoCell.cellBtn setTitle:btnTitles forState:UIControlStateHighlighted];
        [infoCell.cellBtn setImage:[UIImage imageNamed:btnImage] forState:UIControlStateNormal];
        [infoCell.cellBtn addTarget:self action:@selector(callPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    else if ([identifier  isEqualToString:kNestsDefault_TableViewCell])
    {
        UITableViewCell* infoCell =(UITableViewCell*)cell;
        infoCell.textLabel.text =infoDic[@"titles"];
        
    }
    else if ([identifier isEqualToString:kNestsShopingAppraiseTableViewCell])
    {
        
    
    }
    
    
   
    NSNumber* isAccessory =infoDic[@"accessory"];
    if ([isAccessory isKindOfClass:[NSNumber class]]&&isAccessory.boolValue) {
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSNumber* noLine =infoDic[@"noLine"];
    if (!noLine.boolValue) {//默认有线
        //line
        UIView* line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.bounds), CGRectGetWidth(cell.bounds), 1)];
        [line setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
        [cell addSubview:line];

    }
    
    return cell;
}

#pragma mark-TableVeiwHeader&Bottom
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height =0.0;
    if (section==0) {
        
        height =0.0;
    }
    else
    {
        height =10.0;
    }
    
    return height;//section头部高度
}

//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 100)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.frame), 1)];
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
    __weak NestsParallaxViewController *weakSelf = self;
    
    
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
    __weak NestsParallaxViewController *weakSelf = self;
    
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
    __weak NestsParallaxViewController *weakSelf = self;
    
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
#pragma mark-拨打电话
-(void)callPhoneAction:(UIButton*)btn
{
    NSString* phoneNumber =[btn  titleForState:UIControlStateNormal];
    
    if ([phoneNumber  isKindOfClass:[NSString class]]&&phoneNumber.length>0) {
         [NestsKit callPhone:phoneNumber];
    }
   

}



#pragma mark-Network
-(void)netMerShopingkepperInfo
{

    if ([self.mID  isKindOfClass:[NSString class]]&&(![self.mID.trim  isEqualToString:@""])) {
        [self.networkClient netMerShopingkepperInfo:NET_MER_SHOPINGKEPPER_INFO_ID  mId:self.mID delegate:self
                                          didFinish:@selector(didNetMerShopingkepperInfoFinish:userInfo:)
                                          didFailed:@selector(didFailed:userInfo:)
                                           userInfo:nil];
        

    }
   
    
    
    
}

- (void)didNetMerShopingkepperInfoFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"商家信息请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSDictionary class]]) {
                NSDictionary* infoDic = infoData;
                NSString* addr =infoDic[@"addr"];
                NSString* desc =infoDic[@"desc"];
                NSString* favorable =infoDic[@"favorable"];
                NSString* goodReptRate =infoDic[@"goodReptRate"];
                NSString* lat =infoDic[@"lat"];
                NSString* lng =infoDic[@"lng"];
                
                
                  NSString* logo =infoDic[@"logo"];
                  NSString* mId =infoDic[@"mId"];
                  NSString* name =infoDic[@"name"];
                  NSString* phone =infoDic[@"phone"];
                
                 NSNumber* count =infoDic[@"count"];
                
                  self.dataSource.addr =addr;
                   self.dataSource.desc =desc;
                   self.dataSource.favorable =favorable;
                   self.dataSource.goodReptRate =goodReptRate;
                   self.dataSource.lat =lat;
                   self.dataSource.lng =lng;
                   self.dataSource.logo =logo;
                   self.dataSource.mId =mId;
                   self.dataSource.name =name;
                   self.dataSource.phone =phone;
                   self.dataSource.recCount =[NSString stringWithFormat:@"%@",count];
      
                [self initShopingInfo];
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
//        default:
//        {
//            messages =APP_NETWORK_DEFAULT_ARRER;
//        }
//            break;
//    }
//    
//
//        
//        [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//        
//    
//
//    
//}

#pragma mark-initShopingInfo
-(void)initShopingInfo
{
    for (int index=0; index<[self.shopingInfoArray count]; index++) {
        NestsMMScrollPage* pages  =[self.shopingInfoArray objectAtIndex:index];
        
        NSString* infoImage =[SharedNestsHelper imageBaseURL:self.dataSource.logo];
        UIImageView *mountainImage =[[UIImageView alloc] init];
        [mountainImage  sd_setImageWithURL:[NSURL URLWithString:infoImage] placeholderImage:[UIImage imageNamed:@"mountains.jpg"]];
//        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mountains.jpg"]];
        [mountainImage setFrame:CGRectMake(0, 0, self.nestsMMScrollPresenter.frame.size.width, self.nestsMMScrollPresenter.frame.size.height)];
        pages.titleLabel.text =self.dataSource.name;
        pages.detailLabel.text =self.dataSource.desc;
        [pages.backgroundView addSubview:mountainImage];
        
        
    }

}
@end
