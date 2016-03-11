//
//  HYZRegisterViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZRegisterViewController.h"

#import "RegexKitLite.h"

#import "MBProgressHUD.h"

@interface HYZRegisterViewController ()

@property (nonatomic, strong) HYZLoginTextView      *userTextView;

@property (nonatomic, strong) HYZLoginTextView      *pswTextView;

@property (nonatomic, strong) HYZLoginTextView      *pswAgainTextView;

@end

@implementation HYZRegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"注册";
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
//    用户名
    _userTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:@"请输入邮箱"];
    
    [self.view addSubview:_userTextView];
    
    
//    密码
    _pswTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 130, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"登录密码"];
    
    _pswTextView.textField.secureTextEntry =YES;
    
    [self.view addSubview:_pswTextView];
    
    
//    确认密码
    _pswAgainTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 180, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"确认密码"];
    
    _pswAgainTextView.textField.secureTextEntry =YES;
    
    [self.view addSubview:_pswAgainTextView];
    
    
//    注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
    registerButton.frame = CGRectMake(15, 230, 300, 35);
    
    [registerButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];

    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:registerButton];
}

//注册按钮
- (void)registerButtonClick
{
    [self textFieldResignFistResponder];
    
    BOOL a = [self.userTextView.textField.text isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
    
    if (a == NO)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"请输入正确的邮箱"
                              
                              message:nil
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    else if (self.userTextView.textField.text == nil || self.pswTextView.textField.text == nil || self.pswAgainTextView.textField.text == nil || [self.userTextView.textField.text isEqualToString:@""] || [self.pswTextView.textField.text isEqualToString:@""]|| [self.pswTextView.textField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"用户名或密码不能为空"
                              
                              message:nil
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    else if (self.pswTextView.textField.text.length >= 12)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"密码不能大于12位"
                              
                              message:nil
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    else if (![self.pswAgainTextView.textField.text isEqualToString:self.pswTextView.textField.text])
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"两次输入的密码不一致"
                              
                              message:nil
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"OK"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
        
        return;
    }
    
    else if ([self.pswTextView.textField.text isEqualToString:self.pswAgainTextView.textField.text])
    {
        BOOL a = [self.userTextView.textField.text isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
        
        if (a == NO)
        {
            UIAlertView *alert = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"请输入正确的邮箱"
                                  
                                  message:nil
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"OK"
                                  
                                  otherButtonTitles:nil, nil];
            
            [alert show];
            
            return;
        }
        else
        {
            MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            hud.labelText = NSLocalizedString(@"加载中...", nil);
            
            NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/regist.do?username=%@&password=%@",URL_HTTP,_userTextView.textField.text,_pswTextView.textField.text];
            
            HYZRegisterRequest *registerReuquest = [[HYZRegisterRequest alloc] init];
            
            registerReuquest.delegate = self;
            
            [registerReuquest registerRequest:urlString];
        }
        
        return;
    }
    else{}
}

#pragma mark - 
#pragma mark HYZRegisterRequestDelegate -

- (void)registerSuccessString:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:_userTextView.textField.text
                          
                          message:successString
                          
                          delegate:self
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)requestFaildString:(NSString *)faildString
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldResignFistResponder];
}

- (void)textFieldResignFistResponder
{
    [_userTextView.textField resignFirstResponder];
    
    [_pswTextView.textField resignFirstResponder];
    
    [_pswAgainTextView.textField resignFirstResponder];
}

#pragma mark -
#pragma mark UIAlertViewDelegate -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
