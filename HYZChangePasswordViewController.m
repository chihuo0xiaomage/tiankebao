//
//  HYZChangePasswordViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZChangePasswordViewController.h"

#import "NSString+Base64.h"

#import "MBProgressHUD.h"

#import "HYZGetCardDetailModel.h"

@interface HYZChangePasswordViewController ()

@end

@implementation HYZChangePasswordViewController

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
    
    [self creatForeTextFidld];
}

- (void)creatForeTextFidld
{
//    卡号
    _cardNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 80, 280, 40)];
    
    _cardNumberTextField.borderStyle = UITextBorderStyleLine;
    
    _cardNumberTextField.delegate = self;
    
    _cardNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _cardNumberTextField.font = [UIFont systemFontOfSize:20];
    
    [self.view addSubview:_cardNumberTextField];
    
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            _cardNumberTextField.text = getCardModel.cardNo;

        }
    }

    
    
//    老密码
    _oldTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 130, 280, 40)];
    
    _oldTextField.borderStyle = UITextBorderStyleLine;
    
    _oldTextField.delegate = self;
    
    _oldTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _oldTextField.font = [UIFont systemFontOfSize:20];
    
    _oldTextField.placeholder = @"旧密码";
    
    _oldTextField.secureTextEntry = YES;
    
    [self.view addSubview:_oldTextField];
    
    
//    新密码
    _nowOneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, 280, 40)];
    
    _nowOneTextField.borderStyle = UITextBorderStyleLine;
    
    _nowOneTextField.delegate = self;
    
    _nowOneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _nowOneTextField.font = [UIFont systemFontOfSize:20];
    
    _nowOneTextField.placeholder = @"新密码";
    
    _nowOneTextField.secureTextEntry = YES;
    
    [self.view addSubview:_nowOneTextField];
    
    
//    确认新密码
    _nowTwoTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 230, 280, 40)];
    
    _nowTwoTextField.borderStyle = UITextBorderStyleLine;
    
    _nowTwoTextField.delegate = self;
        
    _nowTwoTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _nowTwoTextField.font = [UIFont systemFontOfSize:20];
    
    _nowTwoTextField.placeholder = @"确认新密码";
    
    _nowTwoTextField.secureTextEntry = YES;
    
    [self.view addSubview:_nowTwoTextField];
    
    
//    修改密码按钮
    UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    changeButton.frame = CGRectMake(20, 280, 280, 40);
    
    [changeButton setTitle:@"修改" forState:UIControlStateNormal];
    
    [changeButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    changeButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [changeButton addTarget:self action:@selector(changeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:changeButton];

}

- (void)changeButtonClicked
{
//    键盘失去第一响应
    [self textFieldResignFirstResponder];
    
    [self makeShureTheCardNumberAndCardPassword];
}

- (void)makeShureTheCardNumberAndCardPassword
{
//    去除特殊字符
    NSString *numberStr = [_cardNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *oldPassword = [_oldTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    
    NSString *nowOneStr = [_nowOneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *nowTwoStr = [_nowTwoTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
//    判断
    if ([numberStr isEqualToString:@""] || numberStr == nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"账号不能为空"
                                  
                                  message:@"请输入正确卡号"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([nowOneStr isEqualToString:@""] || nowOneStr == nil )
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"密码不能为空"
                                  
                                  message:@"请输入新密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([nowTwoStr isEqualToString:@""] || nowTwoStr == nil)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"确认密码为空"
                                  
                                  message:@"请输入确认新密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if (![nowOneStr isEqualToString:nowTwoStr])
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"两次密码输入不一致"
                                  
                                  message:@"请确认您的密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([nowOneStr length] != 6 )
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"密码长度必须是六位"
                                  
                                  message:@"请输入六位有效数字"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([numberStr length] != 19)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"账号长度必须是18位"
                                  
                                  message:@"请输有效卡号"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([oldPassword isEqualToString:@""] || oldPassword == nil || [oldPassword length] !=6)
    {
        UIAlertView *noneAlertView = [[UIAlertView alloc]
                                      
                                      initWithTitle:@"密码错误"
                                      
                                      message:@"请输入正确密码"
                                      
                                      delegate:nil
                                      
                                      cancelButtonTitle:@"确定"
                                      
                                      otherButtonTitles:nil, nil];
        
        [noneAlertView show];
    }
    else
    {
        for (int i = 0; i < [nowOneStr length]; i ++)
        {
			unichar str = [nowOneStr characterAtIndex:i];
			
			if (str >= '0' && str <= '9')
            {
                continue;
            }
			else
            {
                UIAlertView *noneAlertView = [[UIAlertView alloc]
                                              
                                              initWithTitle:@"密码只能是数字"
                                              
                                              message:@" 请输入六位有效数字"
                                              
                                              delegate:self
                                              
                                              cancelButtonTitle:@"确定"
                                              
                                              otherButtonTitles:nil, nil];
                
                [noneAlertView show];
                
                return;
            }
        }
        for (int i = 0; i < [numberStr length]; i ++)
        {
            unichar str = [numberStr characterAtIndex:i];
            
            if (str >= '0' && str <= '9')
            {
                continue;
            }
            else
            {
                UIAlertView *noneAlertView = [[UIAlertView alloc]
                                              
                                              initWithTitle:@"帐号只能是数字"
                                              
                                              message:@" 请确认您的卡号"
                                              
                                              delegate:self
                                              
                                              cancelButtonTitle:@"确定"
                                              
                                              otherButtonTitles:nil, nil];
                
                [noneAlertView show];
                
                return;
            }
        }
        
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = NSLocalizedString(@"加载中...", nil);
        
        HYZGetCardTokenRequest *getCardTokenRequest = [[HYZGetCardTokenRequest alloc] init];
        
        getCardTokenRequest.delegate = self;
        
        [getCardTokenRequest getCardToken:numberStr];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldResignFirstResponder];
}

//键盘小时
- (void)textFieldResignFirstResponder
{
    [_cardNumberTextField resignFirstResponder];
    
    [_oldTextField resignFirstResponder];
    
    [_nowOneTextField resignFirstResponder];
    
    [_nowTwoTextField resignFirstResponder];
}

#pragma mark -
#pragma mark HYZGetCardTokenRequestDelegate -

//成功获取token
- (void)getCardTokenSuccess:(NSString *)token
{
//    去除特殊字符
    NSString *numberStr = [_cardNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *oldPassword = [_oldTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    NSString *nowOneStr = [_nowOneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/rePwd.do?cardNo=%@&cardPwd=%@&newPwd=%@&token=%@",URL_HTTP,numberStr,[oldPassword base64EncodedString],[nowOneStr base64EncodedString],token];
    
    HYZChangePasswordRequest *changeRequest = [[HYZChangePasswordRequest alloc] init];
    
    changeRequest.delegete = self;
    
    [changeRequest changeCardPasswordRequest: urlString];
    
}

//获取token失败
- (void)getCardTokenFaild:(NSString *)faildString
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
#pragma mark HYZChangePasswordRequestDelegate -

- (void)changeCardPasswordSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:successString
                          
                          message:@"下次请使用新密码登录"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)changeCardPasswordFaild:(NSString *)faildString
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
