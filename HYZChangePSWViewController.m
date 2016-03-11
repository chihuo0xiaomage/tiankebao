//
//  HYZChangePSWViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZChangePSWViewController.h"

#import "MBProgressHUD.h"

@interface HYZChangePSWViewController ()

@end

@implementation HYZChangePSWViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"修改密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = BACKGROUND_COLOR;

    [self creatTextField];
}

- (void)creatTextField
{
    _oldTextField= [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"请输入旧密码"];
    
    _oldTextField.tag = 10;
    
    _oldTextField.textField.secureTextEntry = YES;
    
    [self.view addSubview:_oldTextField];
    
    _nowOneTextField = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 125, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"输入新密码"];
    
    _nowOneTextField.tag = 11;
    
    _nowOneTextField.textField.secureTextEntry = YES;
    
    [self.view addSubview:_nowOneTextField];
    
    _nowTwoTextField = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 170, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"确认新密码"];
    
    _nowTwoTextField.tag = 12;
    
    _nowTwoTextField.textField.secureTextEntry = YES;
    
    [self.view addSubview:_nowTwoTextField];
    
    
    UIButton *changePSWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    changePSWButton.frame = CGRectMake(15, 215, 290, 35);
    
    [changePSWButton setTitle:@"修改密码" forState:UIControlStateNormal];
    
    [changePSWButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [changePSWButton addTarget:self action:@selector(changePasswordButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [changePSWButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [self.view addSubview:changePSWButton];
}

- (void)changePasswordButtonClick
{
    [self textFieldResignFirstResponder];
    
    [self opinionThePassword];
}

- (void)textFieldResignFirstResponder
{
    [_oldTextField.textField resignFirstResponder];
    
    [_nowOneTextField.textField resignFirstResponder];
    
    [_nowTwoTextField.textField resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldResignFirstResponder];
}

- (void)opinionThePassword
{
    if ([_oldTextField.textField.text isEqualToString:@""] || _oldTextField.textField.text == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"密码不能为空"
                                  
                                  message:@"请输入您的原始密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([_nowOneTextField.textField.text isEqualToString:@""] || _nowOneTextField.textField.text == nil){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"新密码不能为空"
                                  
                                  message:@"请输入新密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if (_nowOneTextField.textField.text.length < 6){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"新密码长度不能低于六位"
                                  
                                  message:@"请输入新密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if (![_nowOneTextField.textField.text isEqualToString:_nowTwoTextField.textField.text]){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"两次输入的密码不一致"
                                  
                                  message:@"请确认您的密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = NSLocalizedString(@"加载中...", nil);
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
        
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/changePasswd.do?username=%@&password=%@&passwd=%@",URL_HTTP,[array objectAtIndex:0],_oldTextField.textField.text,_nowOneTextField.textField.text];
        
        HYZChangePSWRequest *request = [[HYZChangePSWRequest alloc] init];
        
        request.delegate =self;
        
        [request changePasswordRequest:urlString];
    }
}

#pragma mark - 
#pragma mark HYZChangePSWRequestDelegate -

- (void)changePasswordSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:successString
                          
                          message:@""
                          
                          delegate:nil
                          
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
