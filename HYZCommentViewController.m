//
//  HYZCommentViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCommentViewController.h"

#import "MBProgressHUD.h"

@interface HYZCommentViewController ()

@end

@implementation HYZCommentViewController

@synthesize message_idString = _message_idString, tenantCodeString = _tenantCodeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"点评";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _commentRequest = [[HYZDMCommentRequest alloc] init];
    
    _commentRequest.delegate = self;

    
    [self creatSubviews];
}

- (void)creatSubviews
{
    UILabel *questionText = [[UILabel alloc] initWithFrame:CGRectMake(30,60,280,30)];
    
    questionText.backgroundColor = [UIColor clearColor];
    
    questionText.font = [UIFont systemFontOfSize:17.0];
    
    questionText.text = @"1. 请选择服务质量。";
    
    [self.view addSubview:questionText];
    
    NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
    
    [valuesArray addObject:[[MNMRadioGroupValue alloc] initWithValue:@"非常满意" andText:@"非常满意"]];
    
    [valuesArray addObject:[[MNMRadioGroupValue alloc] initWithValue:@"一般" andText:@"一般"]];
    
    [valuesArray addObject:[[MNMRadioGroupValue alloc] initWithValue:@"很差" andText:@"很差"]];
    
    CGFloat margin = 20.0f;
    
    CGFloat width = CGRectGetWidth(self.view.frame) - margin * 2.0f;
    
    CGFloat height = [MNMRadioGroup heightForValues:valuesArray andWidth:width];
    
    _radioGroup = [[MNMRadioGroup alloc] initWithFrame:CGRectMake(margin, 100, width, height) andValues:valuesArray];
    
    _radioGroup.delegate = self;
    
    [self.view addSubview:_radioGroup];
    
    UILabel *questionText1 = [[UILabel alloc] initWithFrame:CGRectMake(30,240,280,30)];
    
    questionText1.backgroundColor = [UIColor clearColor];
    
    questionText1.font = [UIFont systemFontOfSize:17.0];
    
    questionText1.text = @"2. 输入服务意见（100字以内）。";
    
    [self.view addSubview:questionText1];
    
    
    _yijianTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 280, 260, 100)];
    
    _yijianTF.borderStyle = UITextBorderStyleLine;
    
    [self.view addSubview:_yijianTF];
    
    UIButton *tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    tijiaoBtn.frame = CGRectMake(10, 400, 300, 40);
    
    [tijiaoBtn setBackgroundImage:[UIImage imageNamed:@"loginout.png"] forState:UIControlStateNormal];
    
    [tijiaoBtn setTitle:@"提交" forState:UIControlStateNormal];
    
    [tijiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [tijiaoBtn addTarget:self action:@selector(tijiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tijiaoBtn];
}

#pragma mark -
#pragma mark MNMRadioGroupDelegate -

-(void)backgroundTap:(id)sender
{
    [self.yijianTF resignFirstResponder];
}


- (void)MNMRadioGroupValueSelected:(MNMRadioGroupValue *)value
{
    _pingjiaStr = (NSString *)value.value;
}

#pragma mark -
#pragma mark CommitBtnClick -

- (void)tijiaoBtnClick
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    [_yijianTF resignFirstResponder];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSString *urlString = [[NSString stringWithFormat:@"%@vipeng/web/vi/pingjia.do?username=%@&node=%@&yijian=%@&billno=%@",URL_HTTP,[array objectAtIndex:0],_pingjiaStr,_yijianTF.text,_message_idString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [_commentRequest commentUserMessageRequest:urlString];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_yijianTF resignFirstResponder];
}

#pragma mark -
#pragma mark HYZDMCommentRequestDelegate -

- (void)commentSuccess:(NSString *)successString
{
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/message/fuwu_pingjia.do?message_id=%@",URL_HTTP,_message_idString];
    
    [_commentRequest serveCommentRequest:urlString];
}

- (void)serveCommentSuccess:(NSString *)successtring
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:successtring
                          
                          message:nil
                          
                          delegate:self
                          
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
