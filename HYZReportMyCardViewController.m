//
//  HYZReportMyCardViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZReportMyCardViewController.h"

#import "NSString+Base64.h"

#import "MBProgressHUD.h"

#import "HYZGetCardDetailModel.h"

@interface HYZReportMyCardViewController ()

@end

@implementation HYZReportMyCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"挂失";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatTwoTextField];
    
}

- (void)creatTwoTextField
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
    
//    密码
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 130, 280, 40)];
    
    _passwordTextField.borderStyle = UITextBorderStyleLine;
    
    _passwordTextField.delegate = self;
    
    _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _passwordTextField.font = [UIFont systemFontOfSize:20];
    
    _passwordTextField.placeholder = @"密码";
    
    _passwordTextField.secureTextEntry = YES;
    
    [self.view addSubview:_passwordTextField];
    
    
//    挂失按钮
    UIButton *guaShiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    guaShiButton.frame = CGRectMake(20.0, 180.0, 280.0, 40.0);
    
    [guaShiButton setTitle:@"挂失" forState:UIControlStateNormal];
    
    guaShiButton.titleLabel.font = [UIFont systemFontOfSize:20];
    
    [guaShiButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];

    
    [guaShiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [guaShiButton addTarget:self action:@selector(guaShiButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:guaShiButton];

}

- (void)guaShiButtonClicked
{
//    键盘消失
    [self textFieldResignFirstResponder];
    
//    判断卡号和密码是否合法
    [self opinionCardNumberAndPassword];
}

- (void)opinionCardNumberAndPassword
{
//    去除特殊字符
    NSString *numberStr = [_cardNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *passwordStr = [_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([numberStr isEqualToString:@""] || numberStr == nil || [numberStr length] !=19) {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"卡号错误"
                              
                              message:@"请输入您的正确卡号"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else if ([passwordStr isEqualToString:@""] || passwordStr == nil || [passwordStr length] != 6)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              
                              initWithTitle:@"您输入的密码有误"
                              
                              message:@"密码为六位数字"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
        
        [alert show];
    }
    else
    {
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
                                              
                                              initWithTitle:@"卡号为19位数字"
                                              
                                              message:@"请查正您的卡号"
                                              
                                              delegate:self
                                              
                                              cancelButtonTitle:@"确定"
                                              
                                              otherButtonTitles:nil, nil];
                
                [noneAlertView show];
                
                return;
            }
        }
        for (int i = 0; i < [passwordStr length]; i ++)
        {
            unichar str = [passwordStr characterAtIndex:i];
            
            if (str >= '0' && str <= '9')
            {
                continue;
            }
            else
            {
                UIAlertView *noneAlertView = [[UIAlertView alloc]
                                              
                                              initWithTitle:@"密码为6位数字"
                                              
                                              message:@"请输入您的密码"
                                              
                                              delegate:self
                                              
                                              cancelButtonTitle:@"确定"
                                              
                                              otherButtonTitles:nil, nil];
                
                [noneAlertView show];
                
                return;
            }
        }

        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = NSLocalizedString(@"加载中...", nil);
        
        HYZGetCardTokenRequest *getTokenRequest = [[HYZGetCardTokenRequest alloc] init];
        
        getTokenRequest.delegate = self;
        
        [getTokenRequest getCardToken:numberStr];
    }
}

#pragma mark -
#pragma mark HYZGetCardTokenRequestDelegate -

//成功获取token
- (void)getCardTokenSuccess:(NSString *)token
{
//    去除特殊字符
    NSString *numberStr = [_cardNumberTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *passwordStr = [_passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/cardGs.do?cardNo=%@&cardPwd=%@&token=%@",URL_HTTP,numberStr,[passwordStr base64EncodedString],token];
    
    HYZReportRequest *reportRequest = [[HYZReportRequest alloc] init];
    
    reportRequest.delegate = self;
    
    [reportRequest reportMyCardRequest:urlString];
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
#pragma mark HYZReportRequestDelegate -

//挂失成功
- (void)reportMyCardSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:successString
                          
                          message:@"此卡解挂以后才可使用"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

//挂失失败
- (void)reportMyCardFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@"    "
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark - 
#pragma mark UITextFieldDelegate -

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    键盘失去第一响应
    [self textFieldResignFirstResponder];
}

- (void)textFieldResignFirstResponder
{
    [_cardNumberTextField resignFirstResponder];
    
    [_passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
