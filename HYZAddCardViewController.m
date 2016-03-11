//
//  HYZAddCardViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZAddCardViewController.h"

#import "NSString+Base64.h"

#import "MBProgressHUD.h"

@interface HYZAddCardViewController ()

@end

@implementation HYZAddCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"绑定卡";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatTwoTextField];
    
    [self creatLinkButton];
    
    _request = [[HYZLinkMoreCardRequest alloc] init];
    
    _request.delegate = self;
}

//创建输入框
- (void)creatTwoTextField
{
//    卡号
    _cardNumberTextField = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:@"卡号"];
    
    _cardNumberTextField.tag = 10;
    
    [self.view addSubview:_cardNumberTextField];
    
//    密码
    _passwordTextField = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 130, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"密码"];
    
    _passwordTextField.tag = 11;
    
    _passwordTextField.textField.secureTextEntry = YES;
    
    [self.view addSubview:_passwordTextField];
}

//创建绑定按钮
- (void)creatLinkButton
{
    UIButton *linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [linkButton setTitle:@"绑定" forState:UIControlStateNormal];
    
    linkButton.frame = CGRectMake(15, 185, 290, 35);
    
    [linkButton setBackgroundColor:[UIColor redColor]];
    
    [linkButton addTarget:self action:@selector(linkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:linkButton];
}

//绑定按钮被点击
- (void)linkButtonClicked
{
    [self opinionCardNumerAndPassword];
}

//判断卡号和密码是否有效
- (void)opinionCardNumerAndPassword
{
    NSString *numberStr = [_cardNumberTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *passwordStr = [_passwordTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([numberStr isEqualToString:@""] || numberStr == nil){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"对不起"
                                  
                                  message:@"卡号不能为空"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([passwordStr isEqualToString:@""] || numberStr == nil){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"对不起"
                                  
                                  message:@"密码不能为空"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([numberStr length] != 19){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"卡号错误"
                                  
                                  message:@"请输入正确卡号"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else if ([passwordStr length] != 6){
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"密码错误"
                                  
                                  message:@"请输入正确密码"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else
    {
        for (int i = 0; i < [numberStr length]; i ++)
        {
			unichar str = [numberStr characterAtIndex:i];
			
			if (str >= '0' && str <= '9')
            {continue;}
			else
            {
                UIAlertView *noneAlertView = [[UIAlertView alloc]
                                              
                                              initWithTitle:@"卡号只能是数字"
                                              
                                              message:@"请输入有效卡号"
                                              
                                              delegate:nil
                                              
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
            {continue;}
            else
            {
                UIAlertView *noneAlertView = [[UIAlertView alloc]
                                              
                                              initWithTitle:@"密码只能是数字"
                                              
                                              message:@"请输入有效密码"
                                              
                                              delegate:nil
                                              
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
#pragma mark HYZGETCARDTOKENREQUESTDELEGATE -

- (void)getCardTokenSuccess:(NSString *)token
{
    NSString *numberStr = [_cardNumberTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *passwordStr = [_passwordTextField.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//     卡校验
    [_request opitionThisVaildCard:numberStr password:[passwordStr base64EncodedString] token:token];
}

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
#pragma mark HYZLinkMoreCardRequestDelegate -

- (void)checkoutRequestSuccess:(NSString *)cardNumberString password:(NSString *)passwordString
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/bindCard.do?username=%@&card=%@&pwd=%@",URL_HTTP,[array objectAtIndex:0],cardNumberString,passwordString];
    
    [_request linkCardRequest:urlString];
}

- (void)linkSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"恭喜您"
                          
                          message:@"绑定成功!"
                          
                          delegate:self
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)checkoutRequestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@"请查正您的卡号或密码"
                          
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
