//
//  HYZGivenTypeViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGivenTypeViewController.h"

#import "MBProgressHUD.h"

@interface HYZGivenTypeViewController ()

@end

@implementation HYZGivenTypeViewController

@synthesize cardNoString = _cardNoString, cardTokenString = _cardTokenString, DFANAMEString = _DFANAMEString, DFANOString = _DFANOString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"赠送类型";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _dataListArray = [[NSArray alloc] init];
    
    [self creatUI];
    
    [self GivenTypeRequest];
}

- (void)creatUI{
//    卡号
    HYZLoginTextView *cardNumberTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    cardNumberTextView.textField.userInteractionEnabled = NO;
    
    cardNumberTextView.textField.text = _cardNoString;
    
    [self.view addSubview:cardNumberTextView];
    
    
//    充值方案
    HYZLoginTextView *planTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 130, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    planTextView.textField.userInteractionEnabled = NO;
    
    planTextView.textField.text = [NSString stringWithFormat:@"%@ : %@",_DFANAMEString,_DFANOString];
    
    planTextView.textField.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:planTextView];
    
    
    
//    赠送类型
    UILabel *givenTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 170, 280, 40)];
    
    givenTypeLabel.backgroundColor = BACKGROUND_COLOR;
    
    givenTypeLabel.text = @"赠送类型:";
    
    givenTypeLabel.font = [UIFont systemFontOfSize:20];
    
    [self.view addSubview:givenTypeLabel];
    
    
//    赠送类型
    _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _typeButton.frame = CGRectMake(20, 210, 280, 40);
    
    [_typeButton setBackgroundImage:[UIImage imageNamed:@"cart_icon_cardlist.png"] forState:UIControlStateNormal];
    
    [_typeButton setBackgroundColor:[UIColor whiteColor]];
    
    _typeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_typeButton addTarget:self action:@selector(typeButtonClicke) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_typeButton];
    
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    nextButton.frame = CGRectMake(20, 260, 280, 40);
    
    nextButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [nextButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
}

- (void)nextButtonClick{
    HYZGivenDetailViewController *detailViewControrller = [[HYZGivenDetailViewController alloc] init];
    
    detailViewControrller.cardNumberString = _cardNoString;
    
    detailViewControrller.cardTokenString = _cardTokenString;
    
    detailViewControrller.DFANAMEString = _DFANAMEString;
    
    detailViewControrller.DFANOString = _DFANOString;
    
    detailViewControrller.typeString = _typeButton.titleLabel.text;
    
    [self.navigationController pushViewController:detailViewControrller animated:YES];
}

- (void)typeButtonClicke{
    UIActionSheet *cardActionSheet = [[UIActionSheet alloc]
                                      
                                      initWithTitle:@"选择赠送类型"
                                      
                                      delegate:self
                                      
                                      cancelButtonTitle:@"取消"
                                      
                                      destructiveButtonTitle:nil
                                      
                                      otherButtonTitles:nil, nil];
    
    for (int i = 0; i < [_dataListArray count]; i ++ ) {
        [cardActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@",[[_dataListArray objectAtIndex:i] objectForKey:@"DTYPE"]]];
    }
    [cardActionSheet showFromRect:self.view.bounds inView:self.view animated:YES];
    
    [cardActionSheet showInView:self.view];
}

- (void)GivenTypeRequest{
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@/card/open/api/getZsType.do?cardNo=%@&czfaNo=%@&token=%@",URL_HTTP,_cardNoString,_DFANOString,_cardTokenString];
    
    HYZGivenTypeRequest *request = [[HYZGivenTypeRequest alloc] init];
    
    request.delegate = self;
    
    [request getGivenTypeRequest:urlString];
}

#pragma mark -
#pragma mark UIActionSheetDelegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){return;}
    else{
        [_typeButton setTitle:[[_dataListArray objectAtIndex:buttonIndex-1] objectForKey:@"DTYPE"] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark HYZGivenTypeRequestDelegate -

- (void)getGivenTypeSuccess:(NSArray *)dataListArray{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _dataListArray = dataListArray;
    
    [_typeButton setTitle:[[dataListArray objectAtIndex:0] objectForKey:@"DTYPE"] forState:UIControlStateNormal];
}

- (void)requestFaild:(NSString *)faildString{
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
