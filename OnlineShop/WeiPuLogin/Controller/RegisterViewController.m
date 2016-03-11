//
//  RegisterViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 15-1-20.
//  Copyright (c) 2015年 apple. All rights reserved.

#import "RegisterViewController.h"
#import "RegistView.h"
#import "Encrypt.h"
#import "NetWorking.h"

#import "BYShopCartViewController.h"
#import "WeiPuLoginViewController.h"

static NSString * const registResult = @"registResult";
@interface RegisterViewController ()
{
    NSDictionary * _receiveDic;
    RegistView * _userName;
    RegistView * _passName;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"会员注册";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registSucceful:) name:registResult object:nil];
    _userName = [[RegistView alloc] initWithFrame:CGRectMake(20, 100, 280, 40) target:self action:nil image:[UIImage imageNamed:@"yonghu.png"]];
    _userName.textField.placeholder = @"请输入账号";
    [self.view addSubview:_userName];
    
    _passName = [[RegistView alloc] initWithFrame:CGRectMake(_userName.frame.origin.x, _userName.frame.origin.y + _userName.bounds.size.height + 30, 280, 40) target:self action:nil image:[UIImage imageNamed:@"mima.png"]];
    _passName.textField.secureTextEntry = YES;
    _passName.textField.placeholder = @"请输入密码";
    [self.view addSubview:_passName];
    
    if (self.view.bounds.size.height == 480)
    {
        _userName.frame = CGRectMake(20, 80, 280, 40);
        _passName.frame = CGRectMake(_userName.frame.origin.x, _userName.frame.origin.y + _userName.bounds.size.height + 30, 280, 40);
    }
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(disPresentViewController)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;

    
    UIButton * registButton = [UIButton buttonWithType:UIButtonTypeSystem];
    registButton.frame = CGRectMake(_passName.frame.origin.x, _passName.frame.origin.y + _passName.bounds.size.height + 30, 280, 40);
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    registButton.backgroundColor = [UIColor colorWithRed:250/255.0 green:54/255.0 blue:8/255.0 alpha:1.0];
    registButton.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [registButton addTarget:self action:@selector(saveUserPassWord) forControlEvents:UIControlEventTouchUpInside];
    [registButton setTintColor:[UIColor whiteColor]];
    registButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:registButton];
}

- (void)saveUserPassWord
{
    if ([_userName.textField.text isEqualToString:@""] || [_passName.textField.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的用户名或密码为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
    }else{
        [_userName.textField resignFirstResponder];
        [_passName.textField resignFirstResponder];
        CGFloat time = [Encrypt timeInterval];
        NSString * userName = [_userName.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * passWord = [_passName.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //appKey=00001&method=wop.user.member.zhuce&v=1.0&format=json&locale=zh_CN&client=iPhone&userName=%@&passwd=%@&uniqueCode=35701
        NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.user.member.zhuce&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&userName=%@&passwd=%@&uniqueCode=37100", time, [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [passWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSString * sign = [Encrypt generate:keyValues];
        NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        NSLog(@"urlStr:%@",urlStr);
        [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:registResult];
    }
}
- (void)registSucceful:(NSNotification *)notification
{
    //NSLog(@"%d", ++i);
    NSData * data = [notification object];
    _receiveDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString * result = [_receiveDic objectForKey:@"resultCode"];
    NSString * resultCode = [NSString stringWithFormat:@"%@", result];
    NSLog(@"==================%@===================",resultCode);
   // if ([resultCode isEqualToString:@"0"])
    if ([resultCode isEqualToString:@"99"])

        
    {
        NSLog(@"注册成功!%@",[_receiveDic objectForKey:@"memberId"]);
        [[NSUserDefaults standardUserDefaults] setObject:@"Succeful" forKey:@"Succeful"];
        [[NSUserDefaults standardUserDefaults] setObject:[_receiveDic objectForKey:@"memberId"] forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //通知网购首界面推出购物车
       [[NSNotificationCenter defaultCenter] postNotificationName:@"resultCode" object:nil];
       [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您输入的用户名或密码不正确" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:registResult object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resultCode" object:nil];
}
- (void)disPresentViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
