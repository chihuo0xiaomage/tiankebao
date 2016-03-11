//
//  HYZLoginViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZLoginViewController.h"

#import "MBProgressHUD.h"

@interface HYZLoginViewController ()

@end

@implementation HYZLoginViewController

@synthesize request = _request;



@synthesize permissions = _permissions;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.title = @"我的";
        
        self.tabBarItem.image = [UIImage imageNamed:@"icon_5_n.png"];
        
        self.navigationItem.title = @"登录";
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _request = [[HYZLoginRequest alloc] init];
    
    _request.delegate = self;
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatTextField];
    
    [self creatButton];
}

//创建textField
- (void)creatTextField
{
//    用户名
    _userTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:@"添客宝号(注册邮箱)"];
        //_userTextView.textField.secureTextEntry = YES;
    _userTextView.tag = 10;
    
    [self.view addSubview:_userTextView];
    
    
//    密码
    _pswTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 130, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"密码"];
    _pswTextView.textField.secureTextEntry = YES;
    _pswTextView.tag = 11;
    [self.view addSubview:_pswTextView];
}

//创建登录/注册按钮
- (void)creatButton
{
//     登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    loginButton.tag = 100;
    
    [loginButton setBackgroundColor:[UIColor colorWithRed:169.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:0.9]];
    
    [loginButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    loginButton.frame = CGRectMake(15, 180, 140, 30);
    
    [self.view addSubview:loginButton];
    
    
//    注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    registerButton.tag = 101;
    
    [registerButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [registerButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    registerButton.frame = CGRectMake(165, 180, 140, 30);
    
    [self.view addSubview:registerButton];
//    忘记密码按钮
    UIButton *forgetPSWButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [forgetPSWButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    [forgetPSWButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    forgetPSWButton.tag = 102;
    
    [forgetPSWButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    forgetPSWButton.frame = CGRectMake(15, 220, 140, 30);
    
    [self.view addSubview:forgetPSWButton];
    
 /*
//    qq登陆按钮
    HYZLoginButton *qqLoginButton = [[HYZLoginButton alloc] initWithFrame:CGRectMake(15, 260, 135, 30) leftImage:@"qq_login.png" title:@"qq登录"];
    
    qqLoginButton.delegate = self;
    
    [self.view addSubview:qqLoginButton];
//    新浪微博登陆按钮
    HYZLoginButton *sinaLoginButton = [[HYZLoginButton alloc] initWithFrame:CGRectMake(165, 260, 135, 30) leftImage:@"sina_weibo.png" title:@"新浪登录"];
    sinaLoginButton.delegate = self;
    
    [self.view addSubview:sinaLoginButton];
    */
}

- (void)buttonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 100:
        {
//            判断用户名密码不能为空
            if (self.userTextView.textField.text == nil || self.pswTextView.textField.text == nil || [self.userTextView.textField.text isEqualToString:@""] || [self.pswTextView.textField.text isEqualToString:@""])
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      
                                    initWithTitle:@"用户名或密码为空"

                                    message:nil

                                    delegate:self

                                    cancelButtonTitle:@"OK"

                                    otherButtonTitles:nil, nil];
                
                [alert show];
                
            }
            else
            {
//                用户名密码不为空开始登陆
                MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                
                hud.labelText = NSLocalizedString(@"加载中...", nil);
                
                NSString* aToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"PUSH_DEVICE_TOKEN"];
                
                NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/login.do?username=%@&password=%@&devicename=iphone&token=%@",URL_HTTP,self.userTextView.textField.text,self.pswTextView.textField.text,aToken];
                
                [_request loginRequest:urlString userName:self.userTextView.textField.text passwordString:self.pswTextView.textField.text access_token:aToken];
            }

        }
            break;
        case 101:
        {
//            注册
            [self.navigationController pushViewController:[[HYZRegisterViewController alloc] init] animated:YES];
        }
            break;
        case 102:
        {
//            忘记密码
            [self.navigationController pushViewController:[[HYZForgetPSWViewController alloc] init] animated:YES];
        }
            break;
            
        default:
            break;
    }
}
/*
#pragma mark -
#pragma mark HYZLoginButtonDelegate -

- (void)HYZQQLoginButtonClicked
{
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:QQ_APP_ID andDelegate:self];
    _tencentOAuth.redirectURI = @"www.qq.com";
    _permissions = [[NSArray alloc]initWithObjects:@"add_one_blog",@"get_user_info",@"add_t",@"add_pic_t",nil];
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled)
    {

    }
    else
    {

    }
}

-(void)tencentDidNotNetWork
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"网络链接失败" delegate:nil cancelButtonTitle:@"确定"otherButtonTitles:nil, nil];
    [alertView show];
}

    //新浪授权登陆
- (void)HYZSinaLoginButtonClicked
{
    [self.navigationController pushViewController:[[HYZSinaLoginViewController alloc]init] animated:YES];
}
*/
#pragma mark -
#pragma mark HYZLoginRequestDelegate -

//登陆成功
- (void)loginSuccess:(NSString *)successString userName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"USERMESSAGE.plist" error:nil];
    
    if (!docDir) {
            //NSLog(@"Documents 目录未找到");
    }
    NSArray *array = [[NSArray alloc] initWithObjects: _userTextView.textField.text,_pswTextView.textField.text,successString,@"token", nil];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    [array writeToFile:filePath atomically:YES];
    
    if ([_delegate respondsToSelector:@selector(loginSuccess)]) {
        [_delegate loginSuccess];
    }
    
//    HYZReplaceTabBar *replace = [[HYZReplaceTabBar alloc] init];
//    
//    [replace replaceTabBar:self.tabBarController.selectedIndex];
[self.navigationController popViewControllerAnimated:YES];
}

//登陆失败
- (void)loginFaild:(NSString *)FaildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:FaildString
                              
                              message:@"请确认您的账号密码是否有误"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}
/*
#pragma mark -
#pragma mark TencentSessionDelegate -

- (void)tencentDidLogin
{
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length])
    {
//        记录登录用户的OpenID、Token以及过期时间
        [_tencentOAuth accessToken];
        
        [_tencentOAuth openId];
        
        if ([_tencentOAuth openId])
        {
//            判断是不是首次登陆
            NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/usermanager/checkid.do?openid=%@",URL_HTTP,_tencentOAuth.openId];
            
            HYZQQLoginRequest *checkIdRequest = [[HYZQQLoginRequest alloc] init];
            
            checkIdRequest.delegate = self;
            
            [checkIdRequest checkUserIdRequest:urlString];
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"对不起"
                                  
                                  message:@"登录失败"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark - 
#pragma mark HYZQQLoginRequestDelegate -

- (void)checkUserIdSuccess:(NSString *)successString openToken:(NSString *)openToken password:(NSString *)password userName:(NSString *)userName
{
    if ([successString isEqualToString:@"firstlogin"]) {
        HYZLinkEmailViewController *linkViewController = [[HYZLinkEmailViewController alloc] init];
        
        linkViewController.qqUserId = [_tencentOAuth openId];
        
        linkViewController.token = [_tencentOAuth accessToken];
        
        [self.navigationController pushViewController:linkViewController animated:YES];
    }
    else if ([successString isEqualToString:@"login"]){

        NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/login.do?username=%@&password=%@&devicename=iphone&token=%@",URL_HTTP,userName,password,openToken];
        
        [_request loginRequest:urlString userName:userName passwordString:password access_token:openToken];
        
    }else{}
}

- (void)requestFaild:(NSString *)faildString
{
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"网络链接失败"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}
*/
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_userTextView.textField resignFirstResponder];
    
    [_pswTextView.textField resignFirstResponder];
}
/**
 * 登录成功后的回调
 */
//- (void)tencentDidLogin
//{
//    
//}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
//- (void)tencentDidNotLogin:(BOOL)cancelled
//{
//    
//}

/**
 * 登录时网络有问题的回调
 */
//- (void)tencentDidNotNetWork
//{
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
