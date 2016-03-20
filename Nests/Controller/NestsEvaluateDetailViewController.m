//
//  NestsEvaluateDetailViewController.m
//  Nests
//
//  Created by 🐠 on 2/18/16.
//  Copyright © 2016 Daisy. All rights reserved.
//

#import "NestsEvaluateDetailViewController.h"
#import "CornerEvaluateInfoData.h"
#import "CornerEvaluateInfoData+Operation.h"
#import "NestsStyleEvalue_0_TableViewCell.h"
#import "NestsStyleSubtitle_0_TableViewCell.h"
#import "NestsStyleEvalue_1_TableViewCell.h"
#import "NestsStyleText_0_TableViewCell.h"
@interface NestsEvaluateDetailViewController ()<UITableViewDataSource, UITableViewDelegate,StarRatingDelegate,TextFieldCellDelegate>
@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;
@property(nonatomic,retain) CornerEvaluateInfoData* dataSource;

@end

@implementation NestsEvaluateDetailViewController
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
    
    self.title = @"已评价";
    
    [self setupNavigaionBar];
    [self setupMainView];
    [self setupMainTableView];
    
    
       NSString* consumeId =self.infoDataDic[@"consumeId"];
     if ([consumeId  isKindOfClass:[NSString class]]) {
          [self netMerEvaluateDetail:consumeId];
   }

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
    self.dataSource =[[CornerEvaluateInfoData alloc] init];
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
    //    CGRect frame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 50);
    //    self.mainTableHeaderView = [[UIView alloc] initWithFrame:frame];
    //    [self.mainTableHeaderView  setBackgroundColor:self.mainTableView.backgroundColor];
    //    //FootView
    CGRect footFrame = CGRectMake(0, 0,CGRectGetWidth(self.view.frame), 180);
    self.mainTableFootView = [[UIView alloc] initWithFrame:footFrame];
    [self.mainTableFootView  setBackgroundColor:self.mainTableView.backgroundColor];
    //
    CGFloat  btnWidth =300;
    CGFloat start_x =(CGRectGetWidth(self.view.frame)-btnWidth)*0.5;
    
    BButton* btnExit =[[BButton alloc] initWithFrame:CGRectMake(start_x, 20.0f, btnWidth, 40.0f) color:[UIColor colorWithRed:0.99 green:0.77 blue:0.29 alpha:1.0] style:BButtonStyleBootstrapV3];
    [btnExit  setTitle:@"评价" forState:UIControlStateNormal];
    [btnExit addTarget:self action:@selector(evaluateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    BButton* btnReset =[[BButton alloc] initWithFrame:CGRectMake(start_x, 70.0f, btnWidth, 40.0f) color:[UIColor colorWithRed:0.0 green:0.74 blue:0.30 alpha:1.0] style:BButtonStyleBootstrapV3];
    //  [btnReset  setTitle:@"重置密码" forState:UIControlStateNormal];
    //
    ////    [btnReset addTarget:self action:@selector(resetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.mainTableFootView addSubview:btnReset];
    [self.mainTableFootView addSubview:btnExit];
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
    
    NSDictionary* indexDic=[[self.dataSource arraytableRepresentationDetail:_infoDataDic] objectAtIndex:section];
    
    NSString *identifier =indexDic[@"identifier"][row];
    if ([identifier  isEqualToString:kNestsStyleSubtitle_0_TableViewCell]) {
        NSString* lat =self.infoDataDic[@"lat"];
        NSString* lon =self.infoDataDic[@"lng"];
        NSString* name  =self.infoDataDic[@"name"];
        NSString* addr =self.infoDataDic[@"addr"];
        
        CLLocationCoordinate2D pointCoordinate=CLLocationCoordinate2DMake(lat.floatValue,lon.floatValue);
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = pointCoordinate;
        pointAnnotation.title =name;
        pointAnnotation.subtitle = addr;
        
        [self navNestsMapViewController:NO isShowNearby:NO desPoint:pointAnnotation annotaitonArray:nil];
        
        
        
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
    
    NSInteger sections =[[self.dataSource arraytableRepresentationDetail:_infoDataDic]  count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    NSInteger rows =0;
    
    if (sectionIndex<[[self.dataSource arraytableRepresentationDetail:_infoDataDic]  count]) {
        NSDictionary* infoDic=[[self.dataSource arraytableRepresentationDetail:_infoDataDic] objectAtIndex:sectionIndex];
        rows = [infoDic[@"identifier"]  count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    NSDictionary* indexDic=[[self.dataSource arraytableRepresentationDetail:_infoDataDic] objectAtIndex:section];
    
    
    NSString *identifier =indexDic[@"identifier"][row];
    UITableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (infoCell == nil) {
        infoCell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil]
                    objectAtIndex:0];
        
        infoCell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary* infoDic =indexDic[identifier];
    
    if ([identifier  isEqualToString:kNestsStyleSubtitle_0_TableViewCell]) {
        NestsStyleSubtitle_0_TableViewCell* cell =(NestsStyleSubtitle_0_TableViewCell*)infoCell;
        
        cell.titleLabel.text =infoDic[@"titles"];
        cell.subTitleLabel.text =infoDic[@"subTitles"];
        NSString* imageUrl = infoDic[@"icons"];
        NSString* iconImageUrl =infoDic[@"subIcons"];
        NSString* imageStr =[SharedNestsHelper imageBaseURL:imageUrl];
        [cell.cellImage  sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
        [cell.iconImage setImage:[UIImage imageNamed:iconImageUrl]];
        
         cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    else if ([identifier  isEqualToString:kNestsStyleEvalue_0_TableViewCell])
    {
        NestsStyleEvalue_0_TableViewCell* cell =(NestsStyleEvalue_0_TableViewCell*)infoCell;
        cell.titleLabel.text =infoDic[@"titles"];
        NSString* evalueValue =infoDic[@"evalueValues"];
        cell.starRatingView.value =evalueValue.floatValue;
        [cell.starRatingView setEnabled:NO];
        cell.delegate =self;
    }
    else if ([identifier  isEqualToString:kNestsStyleEvalue_1_TableViewCell])
    {
        NestsStyleEvalue_1_TableViewCell* cell =(NestsStyleEvalue_1_TableViewCell*)infoCell;
        cell.delegate =self;
        cell.section =(int)section;
        cell.row =(int)row;
        cell.titleLabel.text =infoDic[@"titles"];
        [cell.contentTextField showViewBorder:[UIColor groupTableViewBackgroundColor] borderWidth:1];
        cell.countLabel.text =self.dataSource.limit;
        [cell.countLabel setHidden:YES];
        NSString*  values =infoDic[@"values"];
        NSString* placeholder =infoDic[@"placeholder"];
        if ([values isEqualToString:@""]) {
            [cell.contentTextField  setPlaceholder:placeholder];
        }
        else
        {
            [cell.contentTextField setText:values];
        }
        
        [cell.contentTextField setEnabled:NO];
        
        
    }else if ([identifier  isEqualToString:kNestsStyleText_0_TableViewCell])
    {
        NestsStyleText_0_TableViewCell*  nestsCell =(NestsStyleText_0_TableViewCell*)infoCell;
        nestsCell.titleLabel.text =infoDic[@"titles"];
        nestsCell.rightLabel.text =infoDic[@"values"];
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
    
    
    
//        NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:section];
//        NSNumber* isAccessory =infoDic[@"accessory"][row];
//        if (isAccessory.boolValue) {
//            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
//        }
    //
    //    cell.titleLabel.text =infoDic[@"titles"][row];
    //    cell.subTitleLabel.text  =infoDic[@"subTitles"][row];
    //    cell.subIcon.image =[UIImage imageNamed:@"zone_pj_rmb"];
    //    NSString* imageUrl =infoDic[@"icons"][row];
    //    [cell.cellImage  sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    //    NSNumber* evalueValue =infoDic[@"evalueValue"][row];
    //    cell.starRatingView.value =evalueValue.floatValue;
    //    cell.starRatingView.enabled=NO;
    //
    //    //line
    UIView* line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(infoCell.bounds), CGRectGetWidth(infoCell.bounds), 1)];
    [line setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
    [infoCell addSubview:line];
    
    return infoCell;
    
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
    __weak NestsEvaluateDetailViewController *weakSelf = self;
    
    
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
    __weak NestsEvaluateDetailViewController *weakSelf = self;
    
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
    __weak NestsEvaluateDetailViewController *weakSelf = self;
    
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

#pragma mark-delegate
-(void)didRatingValue:(id)sender
{
    if ([sender isKindOfClass:[NSNumber class]]) {
        NSNumber* startValue =sender;
        float  selectStarValue =startValue.floatValue;
        if (selectStarValue<=0.0) {
            selectStarValue =0.0;
        }
        self.dataSource.score =[NSString stringWithFormat:@"%f",selectStarValue];
        DDDLog(@"你的评分是:%.1f",selectStarValue);
    }
    
}
#pragma mark-cell Delegate
- (void)textFieldCellDidEndEditing:(NSString*)text
                           section:(NSInteger)section row:(NSInteger)row
{
    DDDLog(@"你选择了＝＝＝%li,==%@",(long)row,text);
    switch (row) {
        case 2:
        {
            NSInteger textLength =text.length;
            if (textLength>100) {
                text =[text substringToIndex:100];
            }
            [self.dataSource  setEvaluate:text];
            self.dataSource.limit =[NSString stringWithFormat:@"%ld/100",textLength];
            
        }
            break;
            
        default:
            break;
    }
    
    [self.mainTableView reloadData];
    
}

#pragma mark-Network
-(void)netMerEvaluateDetail:(NSString*)consumeId

{
    
    
    
    [self.networkClient netMerEvaluateDetail:NET_MER_EVALUATE_DETAIL_ID consumeId:consumeId delegate:self
                                   didFinish:@selector(didNetMerEvaluateDetailFinish:userInfo:)
                                   didFailed:@selector(didFailed:userInfo:)
                                    userInfo:nil];
    
    
}

- (void)didNetMerEvaluateDetailFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"已评价请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSString class]]) {
                
//                NSString* messages =infoData;
//                [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
//                 {
//                     
//                     
//                     
//                 }];
                
                
                id  infoData =resultDic[@"result"];
                if ([infoData  isKindOfClass:[NSDictionary class]]) {
                    
                    NSString* content =infoData[@"content"];
                    NSString* created =infoData[@"created"];
                    self.dataSource.evaluate =content;
                    self.dataSource.dataTime =created;
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
//    [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
//     {
//
//         [self navNestsLoginViewController:YES];
//
//     }];
//
//
//}
#pragma mark-BtnAction
-(void)evaluateBtnAction:(UIButton*)btn
{
    DDDLog(@"评价。。。。。");
//    NSString* consumeId =self.infoDataDic[@"consumeId"];
//    if ([consumeId  isKindOfClass:[NSString class]]) {
//        [self netMerEvaluateID:consumeId score:self.dataSource.score.floatValue  content:self.dataSource.evaluate];
//    }
    
    
}

@end
