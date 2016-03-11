//
//  HYZEmailPSWViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZEmailPSWViewController.h"

#import "MBProgressHUD.h"

@interface HYZEmailPSWViewController ()

@end

@implementation HYZEmailPSWViewController

@synthesize accessTokenString = _accessTokenString, userIdString = _userIdString, emailString = _emailString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"添客宝密码";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = BACKGROUND_COLOR;
    
    self.emailPasswrodTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 80, 290, 36)];
    _emailPasswrodTextField.backgroundColor = [UIColor redColor];
    
    _emailPasswrodTextField.borderStyle = UITextBorderStyleLine;
    
    _emailPasswrodTextField.delegate = self;
    
    _emailPasswrodTextField.placeholder = @"输入添客宝密码";
    
    _emailPasswrodTextField.secureTextEntry = YES;
    
    [self.view addSubview:_emailPasswrodTextField];
    
    
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    sureButton.frame = CGRectMake(15, 130, 290, 40);
    
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [sureButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [sureButton addTarget:self action:@selector(sureButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sureButton];
}

- (void)sureButtonClicked
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/usermanager/checkmail.do?openid=%@&opentoken=%@&username=%@&password=%@",URL_HTTP,_userIdString,_accessTokenString,_emailString,_emailPasswrodTextField.text];
    
    HYZLinkEmailPasswordRequest *passwordRequest = [[HYZLinkEmailPasswordRequest alloc] init];
    
    passwordRequest.delegate = self;
    
    [passwordRequest sentEmailPasswordRequest:urlString];
}

#pragma mark - 
#pragma mark HYZLinkEmailPasswordRequestDelegate -

//    绑定成功
- (void)linkSuccess:(NSString *)successString{
//    通过opengId获取用户信息
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/usermanager/checkid.do?openid=%@",URL_HTTP,_userIdString];
    
    HYZGetUserMessageRequest *getUserMessageRequest = [[HYZGetUserMessageRequest alloc] init];
    getUserMessageRequest.delegate = self;
    
    [getUserMessageRequest getUserMessageRequest:urlString];
}

//    绑定失败
- (void)linkError:(NSString *)errorString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:errorString
                              
                              message:@"请输入您的密码"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

//    请求失败
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

#pragma mark -
#pragma mark HYZGetUserMessageRequestDelegate -

- (void)getMessage:(NSString *)message openToken:(NSString *)token password:(NSString *)password userName:(NSString *)username{

    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/login.do?username=%@&password=%@&devicename=iphone&token=%@",URL_HTTP,username,password,token];
    
    HYZLoginRequest *loginRequest = [[HYZLoginRequest alloc] init];
    
    loginRequest.delegate = self;
    
    [loginRequest loginRequest:urlString userName:username passwordString:password access_token:token];
}

- (void)loginSuccess:(NSString *)successString userName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"USERMESSAGE.plist" error:nil];
    
    if (!docDir) {
        
    }
    NSArray *array = [[NSArray alloc] initWithObjects: nameString,pWSSTring,successString,access_token, nil];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    [array writeToFile:filePath atomically:YES];
    
//    HYZReplaceTabBar *replace = [[HYZReplaceTabBar alloc] init];
//    
//    [replace replaceTabBar:self.tabBarController.selectedIndex];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginFaild:(NSString *)FaildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:FaildString
                              
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
