//
//  OrderViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-7-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()
{
    UIWebView * _webView;
}
@end

@implementation OrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"服务预约";
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    NSURLCache * urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1*1024*512];
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSString * urlStr = @"http://192.168.0.223:8081/vipeng/guajiang/getRquest.do?userId=1&activityId=19";
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
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
