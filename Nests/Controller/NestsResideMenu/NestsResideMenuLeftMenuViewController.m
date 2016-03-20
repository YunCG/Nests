//
//  NestsResideMenuMenuViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "NestsResideMenuLeftMenuViewController.h"
#import "CornerNestsResideMenuInfoData.h"
#import "CornerNestsResideMenuInfoData+Operation.h"


@interface NestsResideMenuLeftMenuViewController ()

@property (strong, readwrite, nonatomic) UITableView *tableView;
@property (strong, readwrite, nonatomic) UIView* avatarView;
@property (strong, nonatomic) UILabel* userLabel;
@property (strong, nonatomic) UIButton* photoBtn;
@property(nonatomic,retain) CornerNestsResideMenuInfoData* dataSource;

@end

@implementation NestsResideMenuLeftMenuViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupDataSource];
    }
    return self;
}
- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupAvatar];
    [self setupMainTableView];
    
      [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(refreshDataInfo) name:NESTS_REFRESH_LEFT object:nil];
}

-(void)refreshDataInfo
{
    [self performSelector:@selector(netUserPersonInfo)];
    [self refreshInfo];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [self performSelector:@selector(netUserPersonInfo)];
    [self refreshInfo];
}
#pragma mark-DataSource
- (void)setupDataSource {
    self.dataSource =[[CornerNestsResideMenuInfoData alloc] init];
}
#pragma mark-Avatar
-(void)setupAvatar
{

   self.avatarView = ({
  UIView* avatarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,(self.view.frame.size.height - 54 * 5) / 2.0f)];
    
       avatarView;
   });
    
//    [self.avatarView showViewBorder:[UIColor greenColor] borderWidth:1.0];
    [self.view addSubview:self.avatarView];
    
  
   self.photoBtn = ({
        UIButton* photoBtn =[[UIButton alloc] initWithFrame:CGRectMake(70, 45, 62, 62)];
//        [photoBtn  sd_setImageWithURL:[NSURL URLWithString:NESTS_USER_PHOTO] forState:UIControlStateNormal];
        photoBtn.layer.masksToBounds=YES;
        photoBtn.layer.cornerRadius = 5.0;
       [photoBtn addTarget:self action:@selector(photoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        photoBtn;
   });
//       [self.photoBtn  showViewBorder:[UIColor redColor] borderWidth:1.0];
     [self.view addSubview:self.photoBtn];
    
     self.userLabel = ({
         
         UILabel* userLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 110, 182, 20)];
         userLabel.font =[UIFont systemFontOfSize:14];
         userLabel.textColor =[UIColor darkGrayColor];
         userLabel.textAlignment =NSTextAlignmentCenter;
         userLabel.text =@"用户名";
         userLabel;
         
          });
    
//    [self.userLabel setText:self.dataSource.userName];
//     [self.userLabel  showViewBorder:[UIColor greenColor] borderWidth:1.0];
     [self.view addSubview:self.userLabel];
    
    
         

}
#pragma mark-TableView
-(void)setupMainTableView
{
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 54 * 5) / 2.0f, self.view.frame.size.width, 54 * 5) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView;
    });
   
//     [self.tableView showViewBorder:[UIColor redColor] borderWidth:1.0];
    [self.view addSubview:self.tableView];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    
    NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:section];
    NSString* title =infoDic[@"titles"][row];
     NSString* link =self.dataSource.userUrl;
    
    if ([title  isEqualToString:NestsResideMenu_Score]) {
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsHomeViewController:NESTS_CONTENT_ID_SCORE infoDic:nil]]
                                                     animated:YES];
      
        [self.sideMenuViewController hideMenuViewController];
        
        

    }else if([title  isEqualToString:NestsResideMenu_EVALUATE]) {
//        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsEvaluateViewController]]
//                                                     animated:YES];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsHomeViewController:NESTS_CONTENT_ID_EVALUATE infoDic:nil]]
                                                     animated:YES];

          [self.sideMenuViewController hideMenuViewController];
      
    }else if([title  isEqualToString:NestsResideMenu_Message]) {
//        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsMessageViewController]]
//                                                     animated:YES];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsHomeViewController:NESTS_CONTENT_ID_MESSAGE infoDic:nil]]
                                                     animated:YES];

          [self.sideMenuViewController hideMenuViewController];
     
    }else if([title  isEqualToString:NestsResideMenu_More]) {
//        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsSettingViewController]]
//                                                     animated:YES];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsHomeViewController:NESTS_CONTENT_ID_MORE infoDic:nil]]
                                                     animated:YES];

          [self.sideMenuViewController hideMenuViewController];
       
    }else{
    
        NSDictionary* infoDic =@{NESTS_WEB_TITLE:title,
                                 NESTS_WEB_LINK:link,
                                 NESTS_WEB_POP_TYPE:[NSNumber numberWithInt:WebPopTypeID_Default]};
//        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsWebViewController:infoDic]]
//                                                     animated:YES];
        
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsHomeViewController:NESTS_CONTENT_ID_WEB infoDic:infoDic]]
                                                     animated:YES];

       [self.sideMenuViewController hideMenuViewController];

    }
        
    

    
    
   }

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    NSInteger sections =[[self.dataSource arraytableRepresentation] count];
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    
    NSInteger rows =0;
    
    if (sectionIndex<[[self.dataSource arraytableRepresentation]  count]) {
        NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:sectionIndex];
        rows = [infoDic[@"titles"]  count];
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
          cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        
    }
    
    if (section<[[self.dataSource arraytableRepresentation]  count]) {
        NSDictionary* infoDic=[[self.dataSource arraytableRepresentation] objectAtIndex:section];
        
        NSString* title =infoDic[@"titles"][row];
        NSString* iconImage =infoDic[@"icons"][row];

        
        cell.textLabel.text =title;
        cell.imageView.image =[UIImage imageNamed:iconImage];
    }
    
  
   
    
    
    return cell;
}

#pragma mark-btnAction
-(void)photoBtnAction:(UIButton*)btn
{
     DDDebug(@"头像点击。。。");

//    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsPersonInfoViewController]]
//                                                 animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
    
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[SharedNestsSceneDispatch nestsHomeViewController:NESTS_CONTENT_ID_PERSONINFO infoDic:nil]]
                                                 animated:YES];
    
      [self.sideMenuViewController hideMenuViewController];
}
#pragma mark-refreshInfoDate
-(void)refreshInfo
{
    [self.userLabel setText:self.dataSource.userName];
    [self.photoBtn  sd_setImageWithURL:[NSURL URLWithString:self.dataSource.userImage] forState:UIControlStateNormal];
    
  
}


#pragma mark-Network
-(void)netUserPersonInfo
{
    

    [self.networkClient netUserPersonInfo:NET_USER_PERSON_INFO_ID delegate:self
                                didFinish:@selector(didNetUserPersonInfoListFinish:userInfo:)
                                didFailed:@selector(didFailed:userInfo:)
                                 userInfo:nil];
    
    
    
    
    
}

- (void)didNetUserPersonInfoListFinish:(id)result userInfo:(NSDictionary *)userInfo {
    
    [SVProgressHUD dismiss];
    NSDictionary* resultDic =[result stringJsonValue];
    DDDebug(@"个人信息信息请求成功＝＝＝%@",resultDic);
    if ([resultDic  isKindOfClass:[NSDictionary class]]) {
        NSNumber*  state =resultDic[@"state"];
        if (state.intValue ==APP_NORMAL_STATE) {
            
            id  infoData =resultDic[@"result"];
            if ([infoData  isKindOfClass:[NSDictionary class]]) {
                NSDictionary* infoDic =infoData;
                NSString* img =infoDic[@"img"];
                NSString* nickName =[NSString stringWithFormat:@"%@",infoDic[@"nickName"]];
                self.dataSource.userImage =[SharedNestsHelper imageBaseURL:img];
                self.dataSource.userName =nickName;
                
                        [self.tableView reloadData];
                [self refreshInfo];
                    
              
            }
            
            
            
            
        }
        else
        {
            
//            id  infoData =resultDic[@"result"];
//            if ([infoData  isKindOfClass:[NSString class]]) {
//                
//                NSString* messages =infoData;
//                NSError* error =[[NSError alloc] initWithDomain:messages code:APP_SERVER_CODE userInfo:nil];
//                [self didFailed:error userInfo:nil];
//                
//            }
            
            
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
//            
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
