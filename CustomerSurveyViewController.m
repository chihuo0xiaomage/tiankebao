//
//  CustomerSurveyViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-7-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CustomerSurveyViewController.h"

@interface CustomerSurveyViewController ()
{
    UIWebView * _webView;
}
@end

@implementation CustomerSurveyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"顾客调查";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURLCache * urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*512];
    
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSString * urlStr = @"http://www.baidu.com";
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0f];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
