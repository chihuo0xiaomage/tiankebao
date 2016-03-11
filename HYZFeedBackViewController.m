//
//  HYZFeedBackViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZFeedBackViewController.h"

#import "MBProgressHUD.h"

@interface HYZFeedBackViewController ()

@end

@implementation HYZFeedBackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"意见反馈";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = BACKGROUND_COLOR;
    
    _request = [[HYZFeedBackRequest alloc] init];
    
    _request.delegate =self;
    
    [self creatUI];
}

- (void)creatUI
{
//    标题
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 64, 290, 80)];
    
    titleLable.numberOfLines = 0;
    
    titleLable.backgroundColor = [UIColor clearColor];
    
    titleLable.font = [UIFont systemFontOfSize:17];
    
    titleLable.text = @"欢迎您提出宝贵的意见和建议,您留下的每一个字都将用来改善我们的软件";
    
    [self.view addSubview:titleLable];
    
    
//    反馈内容
    _feedbackTextView= [[UITextView alloc] initWithFrame:CGRectMake(10, 144, 300, 120)];
    
    self.feedbackTextView.delegate = self;
    
    self.feedbackTextView.text = @"请输入您的反馈意见(200字以内)";
    
    self.feedbackTextView.textColor = [UIColor grayColor];
    
    self.feedbackTextView.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:self.feedbackTextView];
    
    
//    提交按钮
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    submitButton.frame = CGRectMake(10, 280, 300, 30);
    
    [submitButton setBackgroundColor:[UIColor redColor]];
    
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    submitButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:submitButton];
}

//提交按钮点击事件
- (void)submitButtonClicked
{
    [_feedbackTextView resignFirstResponder];
    
    if (_feedbackTextView.text == nil || [_feedbackTextView.text isEqualToString:@""] ||[_feedbackTextView.text isEqualToString:@"请输入您的反馈意见(200字以内)"])
    {
        self.feedbackTextView.text = @"请输入您的反馈意见(200字以内)";
        
        UIAlertView *aleatView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"反馈内容不能为空"
                                  
                                  message:@"请输入您的反馈意见"
                                  
                                  delegate:self
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        
        [aleatView show];
    }
    else
    {
//    查看沙盒下的用户名
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = NSLocalizedString(@"加载中...", nil);
        
        
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
        
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        
        NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/fankui.do?username=%@&fankui=%@",URL_HTTP,[array objectAtIndex:0],_feedbackTextView.text];
        
        [_request sendFeedBackMessage:urlString];
    }
}

#pragma -
#pragma mark UITextViewDelegate Methed -

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入您的反馈意见(200字以内)"])
    {
        textView.text = @"";
        
        textView.textAlignment = NSTextAlignmentLeft;
        
        textView.font = [UIFont systemFontOfSize:18];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_feedbackTextView resignFirstResponder];
    
    if (self.feedbackTextView.text == Nil || [self.feedbackTextView.text isEqualToString:@""])
    {
        self.feedbackTextView.text = @"请输入您的反馈意见(200字以内)";
    }
}

#pragma -
#pragma mark HYZFeedBackRequestDelegate Methed -

- (void)sendSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:successString
                              
                              message:@"感谢您的宝贵意见"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)sendFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"请检查您的网络"
                              
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
