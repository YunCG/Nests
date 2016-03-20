//
//  NestsAreaViewController.m
//  Nests
//
//  Created by 🐠 on 12/26/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsAreaViewController.h"

@interface NestsAreaViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(retain,nonatomic)UITableView* firstTableView;
@property(retain,nonatomic)UITableView* secTableView;
@property(retain,nonatomic)UITableView* thrTableView;

@property(retain,nonatomic)NSMutableArray* firstArray;
@property(retain,nonatomic)NSMutableArray* secArray;
@property(retain,nonatomic)NSMutableArray* thrArray;

@property(copy,nonatomic) NSString* firstIdentity;
@property(copy,nonatomic) NSString* secIdentity;
@property(copy,nonatomic) NSString* thrIdentity;


@property(copy,nonatomic) NSString* firstStr;
@property(copy,nonatomic) NSString* secStr;
@property(copy,nonatomic) NSString* thrStr;

@end

@implementation NestsAreaViewController
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
    self.title = @"筛选";
    [self setupNavigaionBar];
    [self setupMainView];
    [self setupTableView];
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
   
    self.delegate =nil;
    
    self.firstArray =[[NSMutableArray alloc] initWithCapacity:1];
      self.secArray =[[NSMutableArray alloc] initWithCapacity:1];
      self.thrArray =[[NSMutableArray alloc] initWithCapacity:1];
    
    self.firstIdentity =@"";
    self.secIdentity =@"";
    self.thrIdentity =@"";
    
    self.firstStr =@"";
    self.secStr =@"";
    self.thrStr =@"";
    
    
    self.firstArray =  [NSMutableArray arrayWithArray:[SharedNestsSQLite queryCity]];
}
#pragma mark-setup
-(void)setupNavigaionBar
{
    self.navigationController.navigationBar.translucent = NO;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backPopViewController:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectAddress)];
}

-(void)setupMainView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
}


-(void)setupTableView
{
    
    self.firstTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width*0.33, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
    
    
    self.secTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.33, 0 , self.view.frame.size.width*0.33, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
    
    
    self.thrTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*0.66, 0 , self.view.frame.size.width-self.view.frame.size.width*0.66, self.view.frame.size.height) style:UITableViewStyleGrouped];
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
    
    
//    [self.firstTableView showViewBorder:[UIColor greenColor] borderWidth:1.0];
//    [self.secTableView showViewBorder:[UIColor redColor] borderWidth:1.0];
//    [self.thrTableView showViewBorder:[UIColor magentaColor] borderWidth:1.0];
    
    
    [self.view addSubview:self.firstTableView];
      [self.view addSubview:self.secTableView];
      [self.view addSubview:self.thrTableView];

}

#pragma mark -
#pragma mark UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row =indexPath.row;
    NSInteger section =indexPath.section;
    
    if (self.firstTableView==tableView) {
        NSDictionary* infoDic =[self.firstArray objectAtIndex:row];
        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
            self.firstIdentity =infoDic[@"provinceId"];
            self.firstStr  =infoDic[@"provinceName"];
           
           
            [self.secArray removeAllObjects];
            [self.thrArray removeAllObjects];
            
            self.secIdentity =@"";
            self.secStr =@"";
            
            self.thrStr =@"";
            self.thrIdentity =@"";
            
            
             self.secArray =[NSMutableArray arrayWithArray:[SharedNestsSQLite queryDistrict:self.firstIdentity]];
             [self.secTableView  reloadData];
             [self.thrTableView  reloadData];
            
        }
        
    }
    else if (self.secTableView==tableView)
    {
        NSDictionary* infoDic =[self.secArray objectAtIndex:row];
        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
            self.secIdentity =infoDic[@"areaId"];
             self.secStr     =infoDic[@"areaName"];
            
            [self.thrArray removeAllObjects];
            self.thrArray =[NSMutableArray arrayWithArray:[SharedNestsSQLite queryStreet:self.secIdentity provinceID:self.firstIdentity]];
            
        
            
            self.thrStr =@"";
            self.thrIdentity =@"";
            
            [self.thrTableView  reloadData];
        }
    }
    else if (self.thrTableView==tableView)
    {
        NSDictionary* infoDic =[self.thrArray objectAtIndex:row];
        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
            self.thrIdentity =infoDic[@"streetId"];
              self.thrStr  =infoDic[@"streetName"];
        }
    }
    

    
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
    
    NSInteger rows =0;
    
    if (self.firstTableView==tableView) {
        rows =self.firstArray.count;
    }
    else if (self.secTableView==tableView)
    {
          rows =self.secArray.count;
    }
    else if (self.thrTableView==tableView)
    {
          rows =self.thrArray.count;
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
      
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines=0;
        cell.textLabel.lineBreakMode =NSLineBreakByWordWrapping;
        cell.textLabel.textColor = [UIColor darkGrayColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        
        //        cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
        //        [cell setSeparatorInset:UIEdgeInsetsZero];//cell分割线
        //        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    
    if (self.firstTableView==tableView) {
        NSDictionary* infoDic =[self.firstArray objectAtIndex:row];
        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
            cell.textLabel.text =infoDic[@"provinceName"];
             cell.backgroundColor = [UIColor whiteColor];
            
           
//              cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
//            [cell.selectedBackgroundView  setBackgroundColor:[UIColor lightGrayColor]];
        }
      
    }
    else if (self.secTableView==tableView)
    {
        NSDictionary* infoDic =[self.secArray objectAtIndex:row];
        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
            cell.textLabel.text =infoDic[@"areaName"];
             cell.backgroundColor = [UIColor whiteColor];
            
//            cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
//            [cell.selectedBackgroundView  setBackgroundColor:[UIColor grayColor]];

        }
    }
    else if (self.thrTableView==tableView)
    {
        NSDictionary* infoDic =[self.thrArray objectAtIndex:row];
        if ([infoDic  isKindOfClass:[NSDictionary class]]) {
            cell.textLabel.text =infoDic[@"streetName"];
            cell.backgroundColor = [UIColor whiteColor];
            
//            cell.selectedBackgroundView = [[UIView alloc] init];//设置cell选中颜色
//            [cell.selectedBackgroundView  setBackgroundColor:[UIColor darkGrayColor]];

        }
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


-(void)selectAddress
{
    
//    if ([self.firstStr isKindOfClass:[NSString class]]&&[self.firstStr  isEqualToString:@""]) {
//        [UIAlertView  showWithTitle:@"提示" message:@"请选择城市"  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//        
//    }
//   else if ([self.secStr isKindOfClass:[NSString class]]&&[self.secStr  isEqualToString:@""]) {
//        [UIAlertView  showWithTitle:@"提示" message:@"请选择区域"  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//    }
//   else if ([self.thrStr isKindOfClass:[NSString class]]&&[self.thrStr  isEqualToString:@""]) {
//        [UIAlertView  showWithTitle:@"提示" message:@"请选择街道"  style:UIAlertViewStyleDefault cancelButtonTitle:@"确定" otherButtonTitles:nil tapBlock:nil];
//    }
//    else
//    {
        DDDLog(@"你选择了%@:%@:%@",self.firstStr,self.secStr,self.thrStr);
        
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectAddress:)]) {
        NSMutableDictionary* infoDic =[[NSMutableDictionary alloc] initWithCapacity:1];
        
        if ([self.firstStr isKindOfClass:[NSString class]]&&![self.firstStr  isEqualToString:@""]) {
            [infoDic  setObject:self.firstStr forKey:@"firstStr"];
            [infoDic  setObject:self.firstIdentity forKey:@"firstIdentity"];
        }
         if ([self.secStr isKindOfClass:[NSString class]]&&![self.secStr  isEqualToString:@""]) {
             [infoDic  setObject:self.secStr forKey:@"secStr"];
             [infoDic  setObject:self.secIdentity forKey:@"secIdentity"];
         }
        
        if ([self.thrStr isKindOfClass:[NSString class]]&&![self.thrStr  isEqualToString:@""]) {
            [infoDic  setObject:self.thrStr forKey:@"thrStr"];
            [infoDic  setObject:self.thrIdentity forKey:@"thrIdentity"];
        }
        
        [self.delegate selectAddress:infoDic];
        

    }
    
    [self backPopViewController:nil];
        
        
    
//    }
   
}
@end
