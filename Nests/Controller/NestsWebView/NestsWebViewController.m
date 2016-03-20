//
//  NestsWebViewController.m
//  Nests
//
//  Created by 🐠 on 12/6/15.
//  Copyright © 2015 Daisy. All rights reserved.
//

#import "NestsWebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

#define HANDLER_OC_ALERT  @"alertObjectCHandler"
#define HANDLER_OC_BACK @"backBtnObjectCHandler"
#define HANDLER_OC_NAV @"navObjectCHandler"
typedef enum
{
WEBVIEW_TAG_JS_ALERT =10000,
}
WEBVIEW_TAG;

@interface NestsWebViewController ()<UIWebViewDelegate,UIAlertViewDelegate,NJKWebViewProgressDelegate>
{
    UIWebView* _mainWebView;
    NSURLConnection* _urlConnection;
    BOOL _authenticated;
    NSURLRequest *_request;
    NSString* _urlString;
     NSString* _titleString;
    
    WebPopTypeID popType;
    
      NJKWebViewProgressView *_progressView;
        NJKWebViewProgress *_progressProxy;
}

@property(nonatomic,retain) WebViewJavascriptBridge* bridge;
@end


@implementation NestsWebViewController

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
    [self setupWebView];
  
    
    if (self.infoDic) {
        _urlString =self.infoDic[NESTS_WEB_LINK];
        _titleString =self.infoDic[NESTS_WEB_TITLE];
//        _urlString =[[NSBundle mainBundle] pathForResource:@"NestsWebView" ofType:@"html"];
        
//        _urlString=@"http://www.163.com/";
         [self loadWebPageWithString:_urlString];
    }
    
    self.title =_titleString;
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      [self setupWebViewJavascriptBridge];
       [self.navigationController.navigationBar addSubview:_progressView];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //还原导航
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
     self.navigationController.navigationBar.translucent = NO;//navigationBar不透明，位置向下偏移
        [self.navigationController setNavigationBarHidden:NO animated:NO];
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
  _titleString =@"";
    popType =WebPopTypeID_Default;
}
#pragma mark-setup
-(void)setupNavigaionBar
{
    self.navigationController.navigationBar.translucent = NO;//navigationBar不透明，位置向下偏移
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:1.0 green:0.73 blue:0.3 alpha:1.0]];
    [self.navigationController.navigationBar  setTintColor:[UIColor darkGrayColor]];
    
     if (self.infoDic) {
      
         NSString* popTypeStr =self.infoDic[NESTS_WEB_POP_TYPE]?self.infoDic[NESTS_WEB_POP_TYPE]:@"0";
         
         popType =popTypeStr.intValue;
     }
    
    
    if (popType==WebPopTypeID_Left) {
          self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zone_jifen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zone_jifen_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backPopViewController:)];
    }
    
  
}

-(void)setupMainView
{
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
}


-(void)setupWebView
{
    _mainWebView =[[UIWebView alloc] initWithFrame: CGRectMake(0, 0 , self.view.frame.size.width, self.view.frame.size.height)];
    _mainWebView.delegate =self;
//    [_mainWebView showViewBorder:[UIColor greenColor] borderWidth:1.0];
    _mainWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [_mainWebView setBackgroundColor:[UIColor whiteColor]];
//    [_mainWebView showViewBorder:[UIColor redColor] borderWidth:1.0];
    
    
    
      [self setupNJKWebViewProgress];
    
    
    [self.view addSubview:_mainWebView];
    
   
    
}

#pragma mark-NJKWebViewProgress
-(void)setupNJKWebViewProgress
{
    _progressProxy = [[NJKWebViewProgress alloc] init];
//    _mainWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [_progressView.progressBarView  setBackgroundColor:[UIColor lightTextColor]];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
   
    [_progressView setProgress:0.0 animated:YES];
    
  

}


-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
//    if (progress == NJKInteractiveProgressValue) {
//        // The web view has finished parsing the document,
//        // but is still loading sub-resources
//    }
//
    
    NSLog(@"更新进度。。。。%lf",progress);

    NSString* titleStr = [_mainWebView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if ([titleStr  isKindOfClass:[NSString class]]&&![titleStr.trim  isEqualToString:@""]) {
        self.title =titleStr;
    }
    [_progressView setProgress:progress animated:YES];
 
}
#pragma mark-WebViewJavascriptBridge
-(void)setupWebViewJavascriptBridge
{
      [WebViewJavascriptBridge enableLogging];
    
    //WebView Lanch
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_mainWebView webViewDelegate:_progressProxy handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JS加载返回数据: %@", data);
        responseCallback(@"收到了");
    }];

   //AlertAction
    [_bridge registerHandler:HANDLER_OC_ALERT handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"alertObjectCHandler called: %@", data);
        [self  handleJavascript:data registerHandler:HANDLER_OC_ALERT];
       
    }];
    
    
    //BackAction
    [_bridge registerHandler:HANDLER_OC_BACK handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"backBtnObjectCHandler called: %@", data);
        [self  handleJavascript:data registerHandler:HANDLER_OC_BACK];
        
    }];
    
    //Navgation
    [_bridge registerHandler:HANDLER_OC_NAV handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"navObjectCHandler called: %@", data);
        [self  handleJavascript:data registerHandler:HANDLER_OC_NAV];
        
    }];
    
    
}



- (void)sendJavascriptMessage:(NSString*)jsonString {
       NSLog(@"发送消息给JS: %@", jsonString);
    [_bridge send:jsonString responseCallback:^(id response) {
        NSLog(@"sendMessage got response: %@", response);
    }];
}
#pragma mark-JS数据处理
-(void)handleJavascript:(id)data
        registerHandler:(NSString*)registerHandler
{

    if ([registerHandler isEqualToString:HANDLER_OC_ALERT]) {//确定按钮
        
        if ([data  isKindOfClass:[NSDictionary class]]) {
            NSDictionary* jsDic =data;
            NSString* message =jsDic[@"message"];
            NSString* cancelButtonTitle =jsDic[@"cancelButtonTitle"];
            NSString* title =jsDic[@"title"];
            id otherButtonTitles =jsDic[@"otherButtonTitles"];
            
            id tag =jsDic[@"tag"];
            
            NSInteger tagValue =0;
            if ([tag  isKindOfClass:[NSNumber class]]) {
                NSNumber* tagNuber =tag;
                tagValue =tagNuber.intValue;
            }
            
            //
            UIAlertView* alertView =[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
            alertView.tag =tagValue;
            
            if ([otherButtonTitles isKindOfClass:[NSArray class]]) {
                for (NSString* btnTitle in otherButtonTitles) {
                    [alertView  addButtonWithTitle:btnTitle];
                }
            }
            [alertView show];
            

    }
    }
    else if ([registerHandler isEqualToString:HANDLER_OC_BACK])
    {
    
        [self performSelector:@selector(backPopViewController:) withObject:nil];
    }
    
    else if ([registerHandler isEqualToString:HANDLER_OC_NAV])
    {
        if ([data  isKindOfClass:[NSDictionary class]]) {
            NSDictionary* jsDic =data;
              NSString* title =jsDic[@"title"];
            NSString* message =jsDic[@"message"];
             NSString* isHide =jsDic[@"isHide"];
            BOOL isHideNav =isHide.boolValue;
             self.title =title;
            
      
            [self.navigationController setNavigationBarHidden:isHideNav animated:YES];
             self.navigationController.navigationBar.translucent = isHideNav;//navigationBar不透明，位置向下偏移
            
            
        }
    }
    
    
  
}
#pragma mark-JSON
-(NSString*)jsonString:(NSDictionary*)reqDic
{
    NSString *reqStr =@"";
    if (reqDic) {
        //        reqStr = [reqDic JSONString];
        
        if ([NSJSONSerialization isValidJSONObject:reqDic])
        {
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:reqDic options:NSJSONWritingPrettyPrinted error:&error];
            reqStr =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"json===：%@",reqStr);
        }
        else
        {
            
            NSLog(@"JSON 解析失败");
        }
        
        
        //        reqStr=[MBURLHelper encryptUseDES:reqStr key:nil];
        
    }
    
    return reqStr;
}
#pragma mark-WebViewLoading
- (void)loadWebPageWithString:(NSString*)urlString
{
    NSURL *url =[NSURL URLWithString:urlString];
    DDDLog(@"webview 路径===%@",urlString);
     _request =[[NSURLRequest alloc] initWithURL:url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_mainWebView loadRequest:request];
}

#pragma mark-WebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView//开始加载的时候执行该方法。
{
//   [SVProgressHUD showWithStatus:NESTS_TIP_DEFAULT maskType:SVProgressHUDMaskTypeClear];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView//加载完成的时候执行该方法。
{
//   [SVProgressHUD dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error//加载出错的时候执行该方法
{
//   [SVProgressHUD dismiss];
    
//    if ([error code] == NSURLErrorTimedOut||[error code] == NSURLErrorCannotFindHost) {
    NSLog(@"didFailLoadWithError=====%@",error);
        _urlString =[[NSBundle mainBundle] pathForResource:@"NestsWebViewError" ofType:@"html"];
     NSURL *url =[NSURL URLWithString:_urlString];
      NSURLRequest *request =[NSURLRequest requestWithURL:url];
      [_mainWebView loadRequest:request];
//    }
    
   
}

#pragma mark-取消证书验证
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSLog(@"Did start loading: %@ auth:%d", [[request URL] absoluteString], _authenticated);
    

    
    if (!_authenticated) {
        _authenticated = NO;
        _urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [_urlConnection start];
        return NO;
    }
    return YES;
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] == 0)
    {
        _authenticated = YES;
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
{
    NSLog(@"WebController received response via NSURLConnection");
       // remake a webview call now that authentication has passed ok.
    _authenticated =YES;
    [_mainWebView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

#pragma mark-delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
         NSInteger tagValue =alertView.tag;
 
            NSLog(@"buttonIndex==%ld",buttonIndex);
            NSString* selectIndex =[NSString stringWithFormat:@"%ld",buttonIndex];
            NSMutableDictionary* infoDic =[[NSMutableDictionary alloc] initWithCapacity:1];
            [infoDic  setObject:@"alertObjectCHandler" forKey:@"handler"];
            [infoDic  setObject:selectIndex forKey:@"selectIndex"];
            [infoDic  setObject:[NSNumber numberWithInteger:tagValue] forKey:@"tag"];
            NSString*  jsonStr = [self  jsonString:infoDic];
            
            
            [self  performSelector:@selector(sendJavascriptMessage:) withObject:jsonStr];


}
@end
