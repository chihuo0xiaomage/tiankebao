//
//  HYZPrepaidPlanViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZPrepaidPlanViewController.h"

@interface HYZPrepaidPlanViewController ()

@end

@implementation HYZPrepaidPlanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"充值方案";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _prepaildPlanArray = [[NSArray alloc] init];
    
    [self creatUI];
    
    [self getCardToken];
}

- (void)getCardToken{
//    获取默认卡的token
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
  hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            _cardNoString = getCardModel.cardNo;
            
            HYZGetCardTokenRequest *getTokenRequest = [[HYZGetCardTokenRequest alloc] init];
            
            getTokenRequest.delegate = self;
            
            [getTokenRequest getCardToken:getCardModel.cardNo];
        }
    }
}

- (void)creatUI
{
//    用户名
    _cardNumberTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    _cardNumberTextView.textField.userInteractionEnabled = NO;
    
    [self.view addSubview:_cardNumberTextView];
    
    
    
    UILabel *prepaildPlanLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 280, 40)];
    
    prepaildPlanLabel.backgroundColor = BACKGROUND_COLOR;
    
    prepaildPlanLabel.text = @"充值方案:";
    
    prepaildPlanLabel.font = [UIFont systemFontOfSize:20];
    
    [self.view addSubview:prepaildPlanLabel];
    
    
    
    _prepaildPlanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _prepaildPlanButton.frame = CGRectMake(20, 160, 280, 40);
    
    [_prepaildPlanButton setBackgroundImage:[UIImage imageNamed:@"cart_icon_cardlist.png"] forState:UIControlStateNormal];
    
    [_prepaildPlanButton setBackgroundColor:[UIColor whiteColor]];
    
    _prepaildPlanButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [_prepaildPlanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_prepaildPlanButton addTarget:self action:@selector(prepaildPlanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_prepaildPlanButton];
    
    
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    nextButton.frame = CGRectMake(20, 220, 280, 40);
    
    nextButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [nextButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
}

- (void)nextButtonClick{
    
    HYZGivenTypeViewController *givenTypeiewController =[[HYZGivenTypeViewController alloc] init];
    
    givenTypeiewController.DFANAMEString = _DFANAMEString;

    givenTypeiewController.DFANOString = _DFANOString;
    
    givenTypeiewController.cardNoString = _cardNoString;
    
    givenTypeiewController.cardTokenString = _tokenString;
    
    [self.navigationController pushViewController:givenTypeiewController animated:YES];
}

- (void)prepaildPlanButtonClick
{
    UIActionSheet *cardActionSheet = [[UIActionSheet alloc]
                                      
                                      initWithTitle:@"选择充值方案"
                                      
                                      delegate:self
                                      
                                      cancelButtonTitle:@"取消"
                                      
                                      destructiveButtonTitle:nil
                                      
                                      otherButtonTitles:nil, nil];
    
    for (int i = 0; i < [_prepaildPlanArray count]; i ++ ) {
        [cardActionSheet addButtonWithTitle:[NSString stringWithFormat:@"%@ : %@",[[_prepaildPlanArray objectAtIndex:i] objectForKey:@"DFANAME"],[[_prepaildPlanArray objectAtIndex:i] objectForKey:@"DFANO"]]];
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
        [_prepaildPlanButton setTitle:[NSString stringWithFormat:@"%@ : %@",[[_prepaildPlanArray objectAtIndex:buttonIndex-1] objectForKey:@"DFANAME"],[[_prepaildPlanArray objectAtIndex:buttonIndex-1] objectForKey:@"DFANO"]] forState:UIControlStateNormal];
        
        _DFANAMEString = [[_prepaildPlanArray objectAtIndex:buttonIndex-1] objectForKey:@"DFANAME"];
        
        _DFANOString = [[_prepaildPlanArray objectAtIndex:buttonIndex-1] objectForKey:@"DFANO"];
        
        
    }
}

#pragma mark -
#pragma mark HYZGetCardTokenRequestDelegate -

- (void)getCardTokenSuccess:(NSString *)token{
    
    _tokenString = token;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/card/open/api/getChargingScheme.do?cardNo=%@&token=%@",URL_HTTP,_cardNoString,token];
    
    
    NSLog(@"urlstring:%@",urlString);
    
    
    HYZPrepaidPlanRequest *prepaidPlanRequest = [[HYZPrepaidPlanRequest alloc] init];
    
    prepaidPlanRequest.delegate = self;
    
    [prepaidPlanRequest getPrepaildPlanRequest:urlString];
}

- (void)getCardTokenFaild:(NSString *)faildString{
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
     //  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark HYZPrepaidPlanRequestDelegate -

- (void)getPrepaildPlanRequestSuccess:(NSArray *)dataListArray
{
   [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _prepaildPlanArray = dataListArray;
    
    _cardNumberTextView.textField.text = _cardNoString;
    
    if (dataListArray.count != 0) {
        [_prepaildPlanButton setTitle:[NSString stringWithFormat:@"%@ : %@",[[dataListArray objectAtIndex:0] objectForKey:@"DFANAME"],[[dataListArray objectAtIndex:0] objectForKey:@"DFANO"]] forState:UIControlStateNormal];
        
        _DFANAMEString = [[_prepaildPlanArray objectAtIndex:0] objectForKey:@"DFANAME"];
        
        _DFANOString = [[_prepaildPlanArray objectAtIndex:0] objectForKey:@"DFANO"];
       // NSLog(@"充值方案:%@    %@",_DFANAMEString,_DFANOString);
    }
   
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
