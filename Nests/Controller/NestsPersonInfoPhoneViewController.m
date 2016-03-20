//
//  NestsPersonInfoPhoneViewController.m
//  Nests
//
//  Created by 🐠 on 11/15/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsPersonInfoPhoneViewController.h"
#import "CornerPersonInfoData.h"
#import "CornerPersonInfoData+Operation.h"
#import "NestsStyleTextField_0_TableViewCell.h"
#import "NestsStyleBtn_0_TableViewCell.h"
@interface NestsPersonInfoPhoneViewController ()<UITableViewDataSource, UITableViewDelegate,TextFieldCellDelegate>
@property (strong, readwrite, nonatomic) UITableView *mainTableView;
@property(nonatomic,retain) UIView *mainTableHeaderView ;
@property(nonatomic,retain) UIView *mainTableFootView ;


@end

@implementation NestsPersonInfoPhoneViewController
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
    
    self.title = @"验证手机";
    
    [self setupNavigaionBar];
    [self setupMainView];
    [self setupMainTableView];
    
    
    NSString* phoneNum =self.dataSource.phoneRelNumNew;
    BOOL isPhoneNumValid =[phoneNum isValidateMobile];
    if (isPhoneNumValid) {
   
        [self netSecurityCode:phoneNum];
    }
    else
    {
        NSString* messages =@"手机号无效,请重新输入!";
        [UIAlertView  showWithTitle:@"提示" message:messages style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
        
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
//    self.dataSource =[[CornerPersonInfoData alloc] init];
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
    
    BButton* btnFoot =[[BButton alloc] initWithFrame:CGRectMake(start_x, 20.0f, btnWidth, 40.0f) color:[UIColor colorWithRed:0.99 green:0.77 blue:0.30 alpha:1.0] style:BButtonStyleBootstrapV3];
    [btnFoot  setTitle:@"确定" forState:UIControlStateNormal];
    [btnFoot setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btnFoot addTarget:self action:@selector(netStepBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    BButton* btnReset =[[BButton alloc] initWithFrame:CGRectMake(start_x, 70.0f, btnWidth, 40.0f) color:[UIColor colorWithRed:0.0 green:0.74 blue:0.30 alpha:1.0] style:BButtonStyleBootstrapV3];
    //  [btnReset  setTitle:@"重置密码" forState:UIControlStateNormal];
    //
    ////    [btnReset addTarget:self action:@selector(resetPasswordAction:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.mainTableFootView addSubview:btnReset];
    [self.mainTableFootView addSubview:btnFoot];
    //
    //     [self.mainTableHeaderView showViewBorder:[UIColor redColor] borderWidth:1.0];
    //    [self.mainTableFootView showViewBorder:[UIColor redColor] borderWidth:1.0];
    //
    //    self.mainTableView.tableHeaderView = self.mainTableHeaderView;
    self.mainTableView.tableFooterView = self.mainTableFootView;
    
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
    return 45;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger sections =[[self.dataSource arraytableEditPhoneRepresentation]  count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    NSInteger rows =0;
    
    if (sectionIndex<[[self.dataSource arraytableEditPhoneRepresentation]  count]) {
        NSDictionary* infoDic=[[self.dataSource arraytableEditPhoneRepresentation] objectAtIndex:sectionIndex];
        rows = [infoDic[@"titles"]  count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    NSString *cellName = @"NestsStyleTextField_0_TableViewCell";
    
    
    
    switch (row) {
        case 0:
        {
            cellName = @"NestsStyleBtn_0_TableViewCell";
        }
            break;
        case 1:
        {
            cellName = @"NestsStyleTextField_0_TableViewCell";
        }
            break;
    
            
        default:
        {
             cellName = @"NestsStyleTextField_0_TableViewCell";
        }
            break;
    }
    
    
    
    UITableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (infoCell == nil) {
        infoCell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]
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
    
    if (row==0) {
        NestsStyleBtn_0_TableViewCell* cell =(NestsStyleBtn_0_TableViewCell*)infoCell;
        cell.section =(int)section;
        cell.row =(int)row;
         [cell.cellBtn  addTarget:self action:@selector(sendBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary* infoDic=[[self.dataSource arraytableEditPhoneRepresentation] objectAtIndex:section];
        NSNumber* isAccessory =infoDic[@"accessory"][row];
        if (isAccessory.boolValue) {
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.titleLabel.text =infoDic[@"titles"][row];
        
        NSString*  values =infoDic[@"values"][row];
        NSString* placeholder =infoDic[@"placeholder"][row];
        
        
        //line
        UIView* line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.bounds), CGRectGetWidth(cell.bounds), 1)];
        [line setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
        [cell addSubview:line];
        
        return cell;

    }
    else
    {
        NestsStyleTextField_0_TableViewCell* cell =(NestsStyleTextField_0_TableViewCell*)infoCell;
        cell.delegate =self;
        cell.section =(int)section;
        cell.row =(int)row;
        NSDictionary* infoDic=[[self.dataSource arraytableEditPhoneRepresentation] objectAtIndex:section];
        NSNumber* isAccessory =infoDic[@"accessory"][row];
        if (isAccessory.boolValue) {
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.titleLabel.text =infoDic[@"titles"][row];
        
        NSString*  values =infoDic[@"values"][row];
        NSString* placeholder =infoDic[@"placeholder"][row];
        if ([values isEqualToString:@""]) {
            [cell.contentTextField  setPlaceholder:placeholder];
        }
        else
        {
            [cell.contentTextField setText:values];
        }
        
        NSNumber* isEnable  =infoDic[@"isEnable"][row];
        
        [cell.contentTextField  setEnabled:isEnable.boolValue];
        
        
        //line
        UIView* line =[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(cell.bounds), CGRectGetWidth(cell.bounds), 1)];
        [line setBackgroundColor:[UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0]];
        [cell addSubview:line];
        
         return cell;
    }
    
  
    
   
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
    __weak NestsPersonInfoPhoneViewController *weakSelf = self;
    
    
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
    __weak NestsPersonInfoPhoneViewController *weakSelf = self;
    
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
    __weak NestsPersonInfoPhoneViewController *weakSelf = self;
    
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

#pragma mark-BtnAction
-(void)netStepBtnAction:(UIButton*)btn
{
    DDDLog(@"退出登录");
    [self resignKeyBoardInView:self.view];
    
    NSString* phoneNum =self.dataSource.phoneRelNumNew;
    BOOL isPhoneNumValid =[phoneNum isValidateMobile];
    if (isPhoneNumValid) {
        
        [self netUserPersonPhone:phoneNum securityCode:self.dataSource.phoneValidCode  code2:self.dataSource.phoneChangeCode];
    }
    else
    {
        NSString* messages =@"手机号无效,请重新输入!";
        [UIAlertView  showWithTitle:@"提示" message:messages style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
        
    }

    
    
}

#pragma mark-发送
-(void)sendBtnAction:(UIButton*)btn
{
    
    
    DDDLog(@"发送验证码");
    [self resignKeyBoardInView:self.view];
    NSString* phoneNum =self.dataSource.phoneRelNumNew;
    BOOL isPhoneNumValid =[phoneNum isValidateMobile];
    if (isPhoneNumValid) {
        if ([btn  isKindOfClass:[NestsCountButton class]]) {
            [(NestsCountButton *)btn startCountDown];
        }
        
        //        [self performSelector:@selector(netSecurityCode)];
        
        [self netSecurityCode:phoneNum];
    }
    else
    {
        NSString* messages =@"手机号无效,请重新输入!";
        [UIAlertView  showWithTitle:@"提示" message:messages style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
        
    }
    
    
    
}

#pragma mark-cell Delegate
- (void)textFieldCellDidEndEditing:(NSString*)text
                           section:(NSInteger)section row:(NSInteger)row
{
    DDDLog(@"你选择了＝＝＝%li,==%@",(long)row,text);
    switch (row) {
        case 1:
        {
            [self.dataSource  setPhoneChangeCode:text];
            
        }
            break;
       
            
            
        default:
            break;
    }
    
    
}

#pragma mark-network
//更换手机号
-(void)netUserPersonPhone:(NSString*)phoneNum
          securityCode:(NSString*)securityCode//验证码(旧手机号获得的验证码)
                 code2:(NSString*)code2//验证码2(新手机号码获得的验证码)
{
    [SVProgressHUD showWithStatus:NESTS_TIP_DEFAULT maskType:SVProgressHUDMaskTypeClear];
    

    
    [self.networkClient netUserPersonPhone:NET_USER_PERSON_PHONE_ID newPhone:phoneNum securityCode:securityCode code2:code2  delegate:self
                                 didFinish:@selector(didUserPersonPhoneFinish:userInfo:)
                                 didFailed:@selector(didFailed:userInfo:)
                                  userInfo:nil];
    
    
}

- (void)didUserPersonPhoneFinish:(id)result userInfo:(NSDictionary *)userInfo {
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"手机号码更换请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            NSDictionary* infoDic =resultDic[@"result"];
//            NSString*  code =infoDic[@"code"];
//            self.dataSource.phoneValidCode =code;
//
            if ([infoDic  isKindOfClass:[NSDictionary class]]) {
                
                NSString* tk =infoDic[@"tk"];
                if ([tk  isKindOfClass:[NSString class]]) {
                    [self saveUserDefaultsNotNil:tk keyValue:APP_LOGIN_TOKEN];
                     [self saveUserDefaultsNotNil:self.dataSource.phoneRelNumNew keyValue:APP_USER_PHONE];
                    NSString* message =[NSString stringWithFormat:@"手机号修改成功"];
                    [UIAlertView  showWithTitle:@"提示" message:message  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex)
                     {
                         
//                         [self exitAction];
                         
                     }];
                    

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

//验证码
-(void)netSecurityCode:(NSString*)phoneNum
{
    [SVProgressHUD showWithStatus:NESTS_TIP_DEFAULT maskType:SVProgressHUDMaskTypeClear];
    
    
    [self.networkClient netSecurityCode:NET_USER_SECURITY_ID
                                    cID:phoneNum
                               delegate:self
                              didFinish:@selector(didSecurityCodeFinish:userInfo:)
                              didFailed:@selector(didFailed:userInfo:)
                               userInfo:nil];
    
    
}

- (void)didSecurityCodeFinish:(id)result userInfo:(NSDictionary *)userInfo {
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"网络请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            NSDictionary* infoDic =resultDic[@"result"];
            NSString*  code =infoDic[@"code"];
            self.dataSource.phoneChangeCode =code;
            
            NSString* message =[NSString stringWithFormat:@"验证码:%@",code];
            [UIAlertView  showWithTitle:@"提示" message:message  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
            
            [self.mainTableView reloadData];
            
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
//    [UIAlertView  showWithTitle:@"提示" message:messages  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//    
//    
//    
//    
//}

//-(void)exitAction
//{
//    DDDLog(@"退出登录");
//    
//    //登录初始化参数
//    [self saveUserDefaultsNotNil:@"" keyValue:APP_LOGIN_TOKEN];
//    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_IMAGE];
//    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_URL];
//    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_TITLE_URL];
//    [self saveUserDefaultsNotNil:@"" keyValue:APP_USER_PHONE];
//    
//    [self navNestsLoginViewController:YES];
//    
//    
//}
@end
