//
//  HYZGivenDetailViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGivenDetailViewController.h"

#import "MBProgressHUD.h"

@interface HYZGivenDetailViewController ()

@end

@implementation HYZGivenDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"赠送明细";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _dataMessageArray = [[NSArray alloc] init];
    
    [self creatUI];
    
    [self getGivenDetail];
}

- (void)creatUI{
        //    卡号
    HYZLoginTextView *cardNumberTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    cardNumberTextView.textField.userInteractionEnabled = NO;
    
    cardNumberTextView.textField.text = _cardNumberString;
    
    [self.view addSubview:cardNumberTextView];
    
    
        //    充值方案
    HYZLoginTextView *planTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 130, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    planTextView.textField.userInteractionEnabled = NO;
    
    planTextView.textField.text = [NSString stringWithFormat:@"%@ : %@",_DFANAMEString,_DFANOString];
    
    planTextView.textField.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:planTextView];
    
    
    
    HYZLoginTextView *typeTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 180, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    typeTextView.textField.userInteractionEnabled = NO;
    
    typeTextView.textField.text = _typeString;
    
    [self.view addSubview:typeTextView];
    
    
    
//    赠送明细
    UILabel *givenTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 40)];
    
    givenTypeLabel.backgroundColor = BACKGROUND_COLOR;
    
    givenTypeLabel.text = @"赠送明细:";
    
    givenTypeLabel.font = [UIFont systemFontOfSize:20];
    
    [self.view addSubview:givenTypeLabel];
    
    
    
    _detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _detailButton.frame = CGRectMake(20, 260, 280, 40);
    
    [_detailButton setBackgroundImage:[UIImage imageNamed:@"cart_icon_cardlist.png"] forState:UIControlStateNormal];
    
    [_detailButton setBackgroundColor:[UIColor whiteColor]];
    
    _detailButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_detailButton addTarget:self action:@selector(detailButtonClicke) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_detailButton];
    
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    nextButton.frame = CGRectMake(20, 310, 280, 40);
    
    nextButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [nextButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
}

- (void)getGivenDetail{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [[NSString stringWithFormat:@"%@/card/open/api/getZsMx.do?cardNo=%@&czfaNo=%@&zsType=%@&token=%@",URL_HTTP,_cardNumberString,_DFANOString,_typeString,_cardTokenString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HYZGivenDetailRequest *detailRequest = [[HYZGivenDetailRequest alloc] init];
    
    detailRequest.delegate = self;
    
    [detailRequest getGivenDetailRequest:urlString];
}

- (void)nextButtonClick
{
    HYZTopUpViewController *topUpViewController = [[HYZTopUpViewController alloc] init];
    
    topUpViewController.cardNumberString = _cardNumberString,
    
    topUpViewController.DFANAMEString = _DFANAMEString;
    
    topUpViewController.DFANOString = _DFANOString;
    
    topUpViewController.typeString = _typeString;
    
    topUpViewController.detailString = _detailButton.titleLabel.text;
    
    topUpViewController.cardTokenString = _cardTokenString;
    
    [self.navigationController pushViewController:topUpViewController animated:YES];
}

- (void)detailButtonClicke{
    UIActionSheet *cardActionSheet = [[UIActionSheet alloc]
                                      
                                      initWithTitle:@"选择赠送明细"
                                      
                                      delegate:self
                                      
                                      cancelButtonTitle:@"取消"
                                      
                                      destructiveButtonTitle:nil
                                      
                                      otherButtonTitles:nil, nil];
    
    for (int i = 0; i < [_dataMessageArray count]; i ++ ) {
        [cardActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[[_dataMessageArray objectAtIndex:i] objectForKey:@"DTYPEMX"]]];
    }
    [cardActionSheet showFromRect:self.view.bounds inView:self.view animated:YES];
    
    [cardActionSheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheetDelegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){return;}
    else{
        [_detailButton setTitle:[[_dataMessageArray objectAtIndex:buttonIndex-1] objectForKey:@"DTYPEMX"] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark HYZGivenDetailRequestDelegate -

- (void)getGivenDetailSuccess:(NSArray *)dataListArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _dataMessageArray = dataListArray;
    
    [_detailButton setTitle:[[_dataMessageArray objectAtIndex:0] objectForKey:@"DTYPEMX"] forState:UIControlStateNormal];
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@"请检查您的网络设置"
                          
                          delegate:self
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark -
#pragma mark UIAlertViewDelete -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
