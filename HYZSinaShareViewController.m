//
//  HYZSinaShareViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//
/*
#import "HYZSinaShareViewController.h"

#import "MBProgressHUD.h"

@interface HYZSinaShareViewController ()

@end

@implementation HYZSinaShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"分享";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 70, 300, 30)];
    
    contentLable.text = @"分享内容:";
    
    contentLable.font = [UIFont systemFontOfSize:15];
    
    contentLable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:contentLable];
    
    
    _sinaShareTextView= [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 140)];
    
    [self.view addSubview:self.sinaShareTextView];
    
    self.sinaShareTextView.delegate = self;
    
    self.sinaShareTextView.text = @"添客宝专注实体电商O2O服务体验，我们组织了众多优质的电商服务资源，帮助实体店商低成本享有电子商务的成本红利,下载地址 http://tiankebao.net/index.html";
    
    self.sinaShareTextView.font = [UIFont systemFontOfSize:17];
    
    self.sinaShareTextView.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [shareButton setTitle:@"分享到新浪微博" forState:UIControlStateNormal];
    
    shareButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    shareButton.frame = CGRectMake(20, 250, 280, 30);
    
    [shareButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];

    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareButton];
}

- (void)shareButtonClicked:(UIButton *)sender
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/upload_url_text.json"];
    
    NSString *bodyString = [[NSString stringWithFormat:@"source=%@&access_token=%@&status=%@&visible=0&url=%@",kSINAAppKey,_accessTokenString,_sinaShareTextView.text,@"http://116.255.227.138/images/download_code.png"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HYZSinaShareRequest *sinaRequest = [[HYZSinaShareRequest alloc] init];
    
    sinaRequest.delegate =self;
    
    [sinaRequest shareMessageToSina:urlString bodaString:bodyString];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_sinaShareTextView resignFirstResponder];
}

#pragma mark -
#pragma mark HYZSinaShareRequestDelegate -

- (void)shareSuccess:(NSString *)successString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:successString
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)requestFaild:(NSString *)FaildString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:FaildString
                              message:@""
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