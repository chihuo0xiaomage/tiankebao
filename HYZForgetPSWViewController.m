//
//  HYZForgetPSWViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZForgetPSWViewController.h"

#import "RegexKitLite.h"

#import "MBProgressHUD.h"

@interface HYZForgetPSWViewController ()

@end

@implementation HYZForgetPSWViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"忘记密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatSubViews];
}

- (void)creatSubViews
{
//    textfailde
    _emailTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:@"注册邮箱"];
    
    [self.view addSubview:_emailTextView];
    
    
//    按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [shareButton setTitle:@"确定" forState:UIControlStateNormal];
    
    shareButton.frame = CGRectMake(15, 130, 290, 35);
    
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [shareButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [self.view addSubview:shareButton];
}

- (void)shareButtonClick
{
    [_emailTextView.textField resignFirstResponder];
//    正则表达式判断是不是邮箱
    BOOL a = [self.emailTextView.textField.text isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
//    不是邮箱
    if (a == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"请输入正确的邮箱"
                              
                              message:nil delegate:self
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        [alert show];
    }
//    是邮箱
    else
    {
        [self sendThePasswordToUserEmail];
    }
}

//  发送请求，向用户邮箱发送密码
- (void)sendThePasswordToUserEmail
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/findpas.do?username=%@",URL_HTTP,_emailTextView.textField.text];
    
    HYZForgetPasswordRequest *request = [[HYZForgetPasswordRequest alloc] init];
    
    request.delegate = self;
    
    [request forgotUserPasswordRequest:urlString];
}

#pragma mark -
#pragma mark HYZForgetPasswordRequestDelegate -

- (void)requestSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:successString
                          
                          message:nil
                          
                          delegate:self
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@"请检查您的网络设置"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark -
#pragma mark UIAlertViewDelegate -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_emailTextView.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
