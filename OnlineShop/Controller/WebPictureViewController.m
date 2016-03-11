    //
    //  WebPictureViewController.m
    //  WeiPeng
    //
    //  Created by 宝源科技 on 14-10-17.
    //  Copyright (c) 2014年 apple. All rights reserved.
    //

#import "WebPictureViewController.h"
#import "MBProgressHUD.h"
@interface WebPictureViewController ()<UIWebViewDelegate>
{
    UIWebView * _webView;
}
@end

@implementation WebPictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarController.tabBar.hidden = YES;
            // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
    //- (void)goodsDetailRequest
    //{
    //    CGFloat time = [Encrypt timeInterval];
    //    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.goods.detail.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&isIntroduction=yes&goodsId=%@", time, _goodID];
    //    NSString * sign = [Encrypt generate:keyValues];
    //    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
    //    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:goodDetail];
    //}
    //- (void)goodDetailSucceful:(NSNotification *)notification
    //{
    //    NSData * data = [notification object];
    //    NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
    //    _receiveDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"goodsDetail"];
    //    [_webView loadHTMLString:[NSString stringWithFormat:@"<style>img{width:1280px;}</style>%@", [_receiveDic objectForKey:@"introduction"]] baseURL:nil];
    //}

- (void)viewDidLoad
{
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height + 49)];
        //_webView.backgroundColor = [UIColor clearColor];
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_webView loadHTMLString:[NSString stringWithFormat:@"<style>img{width:1280px;}</style>%@", _htmlString] baseURL:nil];
    [self.view addSubview:_webView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
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
