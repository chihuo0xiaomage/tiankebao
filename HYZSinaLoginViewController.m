//
//  HYZSinaLoginViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//
/*
#import "HYZSinaLoginViewController.h"

#import "NSString+Additions.h"

#import "MBProgressHUD.h"

@interface HYZSinaLoginViewController ()

@end

@implementation HYZSinaLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"新浪微博登陆";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _request = [[HYZLoginRequest alloc] init];
    
    _request.delegate = self;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
  
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0 , 64, WIDTH,[[UIScreen mainScreen] bounds].size.height - 64)];
    
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@&display=mobile",kSINAAppKey,kSINARedirectURI];
        //NSLog(@" url********** = %@", url);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    self.webView.delegate = self;
    
        //请求加载
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
}

#pragma mark -
#pragma mark UIWebViewDelegate -

    //是否允许去加载某个网页
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSURL *url = request.URL;
        //NSLog(@"url = %@", url);
    
	NSString *urlString = url.absoluteString;
        //NSLog(@"urlString = %@", url.absoluteString);
    
        //NSLog(@"url.query = %@", url.query);
	if ([urlString containsString:kSINARedirectURI] && [urlString containsString:@"code="])
    {
        [_webView stopLoading];
        
        [_webView removeFromSuperview];
        
        NSString *code = [[url.query componentsSeparatedByString:@"="] objectAtIndex:1];
        //NSLog(@"code = %@", code);
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (code)
        {
//            MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            
//            hud.labelText = NSLocalizedString(@"加载中...", nil);
        
            NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_id=%@&client_secret=%@&grant_type=%@&code=%@&redirect_uri=%@",kSINAAppKey,SINA_CLIENT_SECRET,@"authorization_code",code,kSINARedirectURI];
            
            HYZSinaLoginRequest *request = [[HYZSinaLoginRequest alloc] init];
            
            [request getSinaToken:urlString];
            
            request.delegate = self;
        }
    }
	return YES;
}

    //  网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
//	NSLog(@"网页开始加载");
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"加载中...";
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//	NSLog(@"网页加载完毕");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    NSLog(@"网页加载失败");
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark -
#pragma mark HYZSinaLoginRequestDelegate -

- (void)requestSuccessUserName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];

    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/login.do?username=%@&password=%@&devicename=iphone&token=%@",URL_HTTP,nameString,pWSSTring,access_token];
    
    [_request loginRequest:urlString userName:nameString passwordString:pWSSTring access_token:access_token];
}
- (void)firstLoginUid:(NSString *)uid accessToken:(NSString *)accessToken
{
    HYZLinkEmailViewController *addEmailViewController = [[HYZLinkEmailViewController alloc] init];
    
    addEmailViewController.qqUserId = uid;
    
    addEmailViewController.token =accessToken;
    
    [self.navigationController pushViewController:addEmailViewController animated:YES];
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"请检查您的网络设置"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark -
#pragma mark HYZLoginRequestDelegate -

    //登陆成功
- (void)loginSuccess:(NSString *)successString userName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"USERMESSAGE.plist" error:nil];
    
    if (!docDir) {
            //NSLog(@"Documents 目录未找到");
    }
    NSArray *array = [[NSArray alloc] initWithObjects: nameString,pWSSTring,successString,access_token, nil];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    [array writeToFile:filePath atomically:YES];
    
        //新浪授权登陆
//    HYZReplaceTabBar *replace = [[HYZReplaceTabBar alloc] init];
//    
//    [replace replaceTabBar:self.tabBarController.selectedIndex];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

    //登陆失败
- (void)loginFaild:(NSString *)FaildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:FaildString
                              
                              message:@"请确认您的账号密码是否有误"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
*/