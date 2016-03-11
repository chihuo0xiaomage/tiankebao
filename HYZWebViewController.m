//
//  HYZWebViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZWebViewController.h"

#import "MBProgressHUD.h"

@interface HYZWebViewController ()

@end

@implementation HYZWebViewController

@synthesize titleString = _titleString , urlString = _urlString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    self.navigationItem.title = _titleString;
    
	self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0 , 64, WIDTH,[[UIScreen mainScreen] bounds].size.height - 64)];
    
    NSString *url = [NSString stringWithFormat:@"%@",_urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}

#pragma mark - 
#pragma mark UIWEBVIEWDELEGATE -

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return YES;
}

    //  网页开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
//	NSLog(@"网页开始加载");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//	NSLog(@"网页加载完毕");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
//    NSLog(@"网页加载失败");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
