//
//  NestsListViewController.m
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsListViewController.h"
#import "NestsStyleSubtitleTableViewCell.h"
#import "CornerHomeInfoData.h"
#import "CornerHomeInfoData+Operation.h"


@interface NestsListViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource, UITableViewDelegate,NestsAMapKitDelegate,NestsAreaViewControllerDelegate>
{
    UIView* _lisView;
    UIButton* navigationRightBtn;
    BOOL isFilter;
}

@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;
@property(nonatomic,retain) CornerHomeInfoData* dataSource;
@property(nonatomic,retain)NSMutableArray* selectArray;
@property(nonatomic,retain)NestsAMapKit* nestsAMapKit;




@property(nonatomic,retain)UISearchDisplayController *searchViewController;
@property(nonatomic,retain)UISearchBar* searchBar;
@end

@implementation NestsListViewController

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
    self.title = @"积分";
     [self setupNavigaionBar];
    [self setupMainView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mainTableView triggerPullToRefresh];
    
    
    
}
#pragma mark-DataSource
- (void)setupDataSource {
    self.dataSource =[[CornerHomeInfoData alloc] init];
    self.selectArray =[[NSMutableArray alloc] initWithCapacity:1];
    self.nestsAMapKit =[[NestsAMapKit alloc] init];
    self.nestsAMapKit.delegate =self;
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
    [self setupListView];

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
    [self  startLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"NestsListFirstViewController will disappear");
}
#pragma mark-listView
-(void)setupListView
{
    _lisView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _lisView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_lisView  setBackgroundColor: [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
    [self.view addSubview:_lisView];
    
//    [_lisView showViewBorder:[UIColor redColor] borderWidth:1.0];
    [self setupMainTableView];
    
}



-(void)setupMainTableView
{
    
    self.mainTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , CGRectGetWidth(_lisView.bounds), CGRectGetHeight(_lisView.bounds)) style:UITableViewStylePlain];
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
    [_lisView  addSubview:self.mainTableView];
    
    //上拉刷新
    [self setupSVPullToRefresh];
    
    
    
    //    //HeaderView
    CGRect frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 45);
    self.mainTableHeaderView = [[UIView alloc] initWithFrame:frame];
    [self.mainTableHeaderView  setBackgroundColor:[UIColor whiteColor]];
//    [self.mainTableHeaderView showViewBorder:[UIColor greenColor] borderWidth:1.0];
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
    
    //搜索
    [self setupSearchBar:self.mainTableHeaderView];
}

-(void)setupSearchBar:(UIView*)bgView
{
    
    UIImage*  searchFileBgImage =[UIImage createColorImg:[UIColor whiteColor] rect:CGRectMake(0, 0,CGRectGetWidth(bgView.frame)-50,35)];
    UIImage*  searchFieldBackgroundImage =[UIImage createColorImg:[UIColor groupTableViewBackgroundColor] rect:CGRectMake(0, 5,CGRectGetWidth(bgView.frame)-50, 35)];
    // Add searchbar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 4.0, CGRectGetWidth(bgView.frame)-50, 35)];
    self.searchBar.placeholder=@"搜索商家";
    self.searchBar.delegate = self;
    //    myBeaconsTableView.tableHeaderView = searchBar;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.searchBar roundCorners:8];
    
    [self.searchBar setBackgroundImage:searchFileBgImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.searchBar setSearchFieldBackgroundImage:searchFieldBackgroundImage forState:UIControlStateNormal];
    [self.searchBar setSearchFieldBackgroundImage:searchFieldBackgroundImage forState:UIControlStateHighlighted];
    
    CGFloat start_x =CGRectGetWidth(bgView.frame)-50;
    BButton* filterBtn =[[BButton alloc] initWithFrame:CGRectMake(start_x,8.0, 45, 30.0f) color:[UIColor  whiteColor] style:BButtonStyleBootstrapV3];
    [filterBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [filterBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [filterBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [filterBtn addTarget:self action:@selector(filterAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [bgView addSubview:filterBtn];
    
    [bgView addSubview:self.searchBar];
    
    //
    //    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0,250, CGRectGetHeight(bgView.frame))];
    //    self.searchBar.placeholder = @"搜索商家";
    //    self.searchBar.showsCancelButton = NO;
    //    self.searchBar.delegate =self;
    //    self.searchBar.searchBarStyle =UISearchBarStyleDefault;
    //    self.searchBar.backgroundColor = [UIColor clearColor];   //修改搜索框背景
    //
    
    //    [self.searchBar  setSearchFieldBackgroundImage:[UIImage imageNamed:@"gjds_new_搜索栏.png"] forState:UIControlStateNormal];
    //    [self.searchBar setSearchFieldBackgroundImage:searchFileBgImage forState:UIControlStateNormal];
    //    [self.searchBar setTintColor:[UIColor groupTableViewBackgroundColor]];
    //    [bgView addSubview:_searchBar];
    //
    //
    [self.searchBar setBackgroundImage:searchFileBgImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    [self.searchBar setSearchFieldBackgroundImage:searchFieldBackgroundImage forState:UIControlStateNormal];
    [self.searchBar setSearchFieldBackgroundImage:searchFieldBackgroundImage forState:UIControlStateHighlighted];
    //
    //    self.searchViewController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    //    self.searchViewController.displaysSearchBarInNavigationBar = NO;
    //    self.searchViewController.delegate = self;
    //    self.searchViewController.searchResultsDataSource = self;
    //    self.searchViewController.searchResultsDelegate = self;
    //    [self.searchViewController.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //
    
    
}
#pragma mark-SearchBar Delegate
// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    DDDLog(@"searchBarTextDidEndEditing");
    
    NSString* searchStr =searchBar.text;
    self.dataSource.shopingName =searchStr;
}
// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
     DDDLog(@"searchBarSearchButtonClicked");
    
    [searchBar resignFirstResponder];
    
    [self netMerShopingkepperList];
    
}

// called when bookmark button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
      DDDLog(@"searchBarBookmarkButtonClicked");
}
 // called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{   DDDLog(@"searchBarCancelButtonClicked");

}

// called when search results button pressed
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
     DDDLog(@"searchBarResultsListButtonClicked");
}

#pragma mark-NestsAdrrDelegate
-(void)selectAddress:(NSDictionary*)addrDic
{
    if ([addrDic  isKindOfClass:[NSDictionary class]]) {
        NSString* firstStr =addrDic[@"firstStr"]?addrDic[@"firstStr"]:@"";
         NSString* firstIdentity =addrDic[@"firstIdentity"]?addrDic[@"firstIdentity"]:@"";
        
         NSString* secStr =addrDic[@"secStr"]?addrDic[@"secStr"]:@"";
         NSString* secIdentity =addrDic[@"secIdentity"]?addrDic[@"secIdentity"]:@"";
        
        NSString* thrStr =addrDic[@"thrStr"]?addrDic[@"thrStr"]:@"";
        NSString* thrIdentity =addrDic[@"thrIdentity"]?addrDic[@"thrIdentity"]:@"";
        
        
        self.dataSource.shopingRegion =firstIdentity;
        self.dataSource.shopingRegion2 =secIdentity;
        self.dataSource.shopingRegion3 =thrIdentity;
        
        isFilter =YES;
          DDDLog(@"你选择了111111%@:%@:%@",firstStr,secStr,thrStr);
    }
   
}
#pragma mark-Search Delegate
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString

{
    NSLog(@"searchString====%@",searchString);
    [self.selectArray removeAllObjects];
    
    NSArray* infoArray =[self.dataSource arraytableRepresentation];
    for(int index = 0; index <infoArray.count; index++)
        
    {
        
        NSDictionary*  infoDic =[infoArray objectAtIndex:index];
        NSString* titles= infoDic[@"titles"];
        
        if([titles hasPrefix:searchString])
            
        {
            
            [self.selectArray  addObject:[infoArray objectAtIndex:index]];
            
        }
        
    }
    
    
    
    return YES;
    
    
    
}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row =indexPath.row;
//    NSInteger section =indexPath.section;
    NSArray* infoArray =nil;
    //搜索
    if(tableView == self.searchViewController.searchResultsTableView)
    {
        infoArray =self.selectArray;
    }
    else
    {
        infoArray =[self.dataSource arraytableRepresentation];
    }

    NSDictionary* infoDic=[infoArray objectAtIndex:row];
    NSString* mID = infoDic[@"mId"];
    [self navNestsParallaxViewController:mID];
    
    
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
    
    
    
    if(tableView == self.searchViewController.searchResultsTableView)
    {
        sections =1;
    }
    else
    {
        sections =1;
    }
    
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    
    
    
    NSInteger rows =0;
    
    
    if(tableView == self.searchViewController.searchResultsTableView)
    {
        rows =self.selectArray.count;
    }
    else
    {
         rows = [[self.dataSource arraytableRepresentation]  count];
  
    }
    
    
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    NSString *cellName = @"NestsStyleSubtitleTableViewCell";
    
    
    
    
    
    
    NestsStyleSubtitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]
                objectAtIndex:0];
    }
    
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    //        cell.backgroundColor = [UIColor whiteColor];
    //        cell.textLabel.font = [UIFont systemFontOfSize:14];
    //        cell.textLabel.textColor = [UIColor darkGrayColor];
    //        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
    //
    //
    //        //        cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
    //        //        [cell setSeparatorInset:UIEdgeInsetsZero];//cell分割线
    //        //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //
    //    }
    
    NSArray* infoArray =nil;
    //搜索
    if(tableView == self.searchViewController.searchResultsTableView)
    {
        infoArray =self.selectArray;
    }
    else
    {
        infoArray =[self.dataSource arraytableRepresentation];
    }
    
    NSDictionary* infoDic=[infoArray objectAtIndex:row];
    
//    NSString* distance =[self calculateDistance:infoDic];
    
    cell.titleLabel.text =infoDic[@"name"];
    cell.detailLabel.text =infoDic[@"addr"];
    NSString* range =infoDic[@"range"];
    cell.rightLabel.text  =[NSString stringWithFormat:@"%@m",range];
    
    NSString* imageURL =infoDic[@"logo"];
    imageURL =[SharedNestsHelper imageBaseURL:imageURL];
    
    [cell.cell_left_image  sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:APP_DEFAULT_IMAGE]];
    
    
    
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
    __weak NestsListViewController *weakSelf = self;
    
    
    // setup pull-to-refresh
    [self.mainTableView addPullToRefreshWithActionHandler:^{
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateTriggered];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"加载中。。。。" forState:SVPullToRefreshStateLoading];
        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
        //        weakSelf.mainTableView.pullToRefreshView.arrowColor =[UIColor redColor];
        weakSelf.mainTableView.indicatorStyle  =UIActivityIndicatorViewStyleWhiteLarge;
        [weakSelf insertRowAtTop];
        
        
        [weakSelf  performSelector:@selector(netMerShopingkepperList)];
       
    }];
    
    //    // 上拉刷新
    //    [self.mainTableView addInfiniteScrollingWithActionHandler:^{
    //        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateTriggered];
    //        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"加载中。。。。" forState:SVPullToRefreshStateLoading];
    //        [weakSelf.mainTableView.pullToRefreshView  setTitle:@"下拉刷新" forState:SVPullToRefreshStateStopped];
    //        //        weakSelf.mainTableView.pullToRefreshView.arrowColor =[UIColor redColor];
    //        weakSelf.mainTableView.indicatorStyle  =UIActivityIndicatorViewStyleWhite;
    //        [weakSelf insertRowAtBottom];
    //    }];
    
}




- (void)insertRowAtTop {
    __weak NestsListViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [weakSelf.mainTableView beginUpdates];
        //        [weakSelf.dataSource insertObject:[NSDate date] atIndex:0];
        //        [weakSelf.mainTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//        [weakSelf.mainTableView endUpdates];
        
        [weakSelf.mainTableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    __weak NestsListViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [weakSelf.mainTableView beginUpdates];
        //        [weakSelf.dataSource addObject:[weakSelf.dataSource.lastObject dateByAddingTimeInterval:-90]];
        //        [weakSelf.mainTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataSource.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
//        [weakSelf.mainTableView endUpdates];
        
        [weakSelf.mainTableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark-BtnAction
-(void)filterAction:(UIButton*)btn
{
    [self.searchBar resignFirstResponder];
    DDDLog(@"筛选。。。。");
    
    
    self.dataSource.shopingRegion =@"";
    self.dataSource.shopingRegion2 =@"";
    self.dataSource.shopingRegion3 =@"";

    
    [self navNestsAreaViewController:self];
}

#pragma mark-定位
-(void)startLocation
{
    
   
    [self.nestsAMapKit startLocation];
    
}

-(void)didLocationFinish:(MAPointAnnotation *)annotation
               regeocode:(AMapLocationReGeocode *)regeocode
{
    DDDLog(@"单次定位成功1111= {lat:%f; lon:%f;}", annotation.coordinate.latitude, annotation.coordinate.longitude);
    
    CGFloat lat =annotation.coordinate.latitude;
    CGFloat lon =annotation.coordinate.longitude;
    //    NSString* title =annotation.title?annotation.title:@"";
    //    NSString* subTitle =annotation.subtitle?annotation.subtitle:@"";
    NSString* location =[NSString stringWithFormat:@"{%f,%f}",lat,lon];
    [self saveUserDefaultsNotNil:location  keyValue:APP_USER_LOCATION];
    
    
    [self performSelector:@selector(netMerShopingkepperList)];
    
}
-(void)didLocationError:(NSError *)error
{
    DDDLog(@"定位失败1111！")
    
    NSArray* titlesArray =@[@"重新定位"];
    __weak NestsListViewController *wSelf = self;
    
    [UIAlertView  showWithTitle:@"提示" message:@"定位失败"  style:UIAlertViewStyleDefault cancelButtonTitle:@"取消" otherButtonTitles:titlesArray tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
     {
         NSLog(@"buttonIndex==%ld",buttonIndex);
         switch (buttonIndex) {
             case 0:
             {
                 DDDLog(@"取消");
             }
                 break;
             case 1:
             {
                 DDDLog(@"重新定位");
                 NestsListViewController *sSelf = wSelf;
                 [sSelf startLocation];
             }
                 break;
                 
             default:
                 break;
         }
     }];
    
    
    
}
//计算距离
-(NSString*)calculateDistance:(NSDictionary*)infoDic
{
    NSString* distanceStr =@"....";
    
    if ([infoDic  isKindOfClass:[NSDictionary class]]) {
        NSString* lat =infoDic[@"lat"]?infoDic[@"lat"]:@"";
        NSString* lon =infoDic[@"lng"]?infoDic[@"lng"]:@"";
        if ((![lat.trim isEqualToString:@""])&&(![lon.trim isEqualToString:@""])) {
            
            
            
            NSString* location =[self objectForUserDefaults:APP_USER_LOCATION];
            CGPoint  locationPoint =CGPointFromString(location);
            NSString* latOrigin =[NSString stringWithFormat:@"%f",locationPoint.x];
            NSString* lonOrigin =[NSString stringWithFormat:@"%f",locationPoint.y];
            
            CLLocationCoordinate2D  desPoint= CLLocationCoordinate2DMake(lat.floatValue,lon.floatValue);
            CLLocationCoordinate2D  originPoingt =CLLocationCoordinate2DMake(latOrigin.floatValue,lonOrigin.floatValue);
            
            
            CLLocationDistance distance= [self.nestsAMapKit distance:originPoingt desPoint:desPoint];
            
            distanceStr =[NSString stringWithFormat:@"%.1f",distance];
            
            
        }
    }
    
    return distanceStr;

}
#pragma mark-Network
-(void)netMerShopingkepperList
{
    //       [self.networkClient netSecurityCode:NET_USER_SECURITY_ID
    //                               delegate:self
    //                              didFinish:@selector(didNetSecurityCodeFinish:userInfo:)
    //                              didFailed:@selector(didNetSecurityCodeFailed:userInfo:)
    //                               userInfo:nil];
    
      [self.searchBar resignFirstResponder];
    
    int pageSize  =1;
    int pageNum  =1000;
    
    
    NSString* location =[self objectForUserDefaults:APP_USER_LOCATION];
    if ([location isKindOfClass:[NSString class]]&&(location.length>0)) {
        DDDLog(@"当前位置坐标＝＝%@",location);
        CGPoint  locationPoint =CGPointFromString(location);
        DDDLog(@"当前位置坐标 = {lat:%f; lon:%f;}", locationPoint.x, locationPoint.y);
        NSString* lat =[NSString stringWithFormat:@"%f",locationPoint.x];
           NSString* lon =[NSString stringWithFormat:@"%f",locationPoint.y];
        
        [self.networkClient  netMerShopingkepperList: NET_MER_SHOPINGKEPPER_LIST_ID type:@"1"
                                                 lat:lat
                                                 lon:lon region:self.dataSource.shopingRegion region2:self.dataSource.shopingRegion2  region3:self.dataSource.shopingRegion3 name:self.dataSource.shopingName  pageSize:pageSize pageNum:pageNum  delegate:self
                                           didFinish:@selector(didNetMerShopingkepperListFinish:userInfo:)
                                           didFailed:@selector(didFailed:userInfo:)
                                            userInfo:nil];


    }
    else
    {
        [self startLocation];
    }
    
    
    
    
}

- (void)didNetMerShopingkepperListFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"信息请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoDic =resultDic[@"result"];
            if ([infoDic  isKindOfClass:[NSDictionary class]]) {
                id list =infoDic[@"list"];
                
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
//        [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//        
//    
//
//    
//}



@end
