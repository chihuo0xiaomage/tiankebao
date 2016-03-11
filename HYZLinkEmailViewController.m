//
//  HYZLinkEmailViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZLinkEmailViewController.h"

#import "RegexKitLite.h"

#import "MBProgressHUD.h"

@interface HYZLinkEmailViewController ()

@end

@implementation HYZLinkEmailViewController

@synthesize qqUserId = _qqUserId;

@synthesize token = _token;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"绑定邮箱";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= BACKGROUND_COLOR;
    
    self.emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 80, 290, 36)];
    
    self.emailTextField.borderStyle = UITextBorderStyleLine;
    
    self.emailTextField.delegate = self;
    
    self.emailTextField.placeholder = @"输入有效邮箱";
    
    [self.view addSubview:self.emailTextField];
    
    
    
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    linkButton.frame = CGRectMake(15, 130, 290, 40);
    
    [linkButton setTitle:@"绑定邮箱" forState:UIControlStateNormal];
    
    [linkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [linkButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [linkButton addTarget:self action:@selector(linkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:linkButton];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_emailTextField resignFirstResponder];
}

- (void)linkButtonClicked
{
    BOOL a = [self.emailTextField.text isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
    
    if (a == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"请输入正确的邮箱"
                              
                              message:nil
                              
                              delegate:self
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else if (self.emailTextField.text == nil || [self.emailTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"邮箱不能为空"
                              
                              message:nil
                              
                              delegate:self
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        [alert show];
    }
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/usermanager/bindemail.do?username=%@&opentoken=%@&openid=%@",URL_HTTP,_emailTextField.text,_token,_qqUserId];
    
    HYZLinkEmailRequest *request = [[HYZLinkEmailRequest alloc] init];
    
    request.delegate = self;
    
    [request AddEmailLinkRequest:urlString];
}

#pragma mark -
#pragma mark HYZLinkEmailRequestDelegate -

- (void)linkEmailSuccess:(NSString *)successString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:successString
                              
                              message:@""
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)linkEmailError:(NSString *)errorString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    HYZEmailPSWViewController *passwordViewController = [[HYZEmailPSWViewController alloc] init];
    
    passwordViewController.accessTokenString = _token;
    
    passwordViewController.userIdString = _qqUserId;
    
    passwordViewController.emailString = _emailTextField.text;
    
    [self.navigationController pushViewController:passwordViewController animated:YES];
}

- (void)requestFaild:(NSString *)faildString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"网络链接失败"
                              
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
