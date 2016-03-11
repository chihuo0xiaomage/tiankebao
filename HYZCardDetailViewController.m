//
//  HYZCardDetailViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCardDetailViewController.h"

#import "MBProgressHUD.h"

@interface HYZCardDetailViewController ()

@end

@implementation HYZCardDetailViewController

@synthesize cardNumberString = _cardNumberString;

@synthesize defaultString = _defaultString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"卡信息";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatMyTableView];
    
    [self obtainCardToken];
}

- (void)creatMyTableView
{
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _cardDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 80, 290, 220) style:UITableViewStylePlain];
    
    _cardDetailTableView.dataSource = self;
    
    _cardDetailTableView.delegate = self;
    
    _cardDetailTableView.layer.cornerRadius = 10;
    
    [self.view addSubview:_cardDetailTableView];
}

- (void)obtainCardToken
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    HYZGetCardTokenRequest *tokenRequest = [[HYZGetCardTokenRequest alloc] init];
    
    tokenRequest.delegate = self;
    
    [tokenRequest getCardToken:_cardNumberString];
}

#pragma mark - 
#pragma mark HYZGetCardTokenRequestDelegate -

- (void)getCardTokenSuccess:(NSString *)token
{
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/cardDetail.do?cardNo=%@&token=%@",URL_HTTP,_cardNumberString,token];
    
    HYZCardDetailMessageRequest *messageRequest = [[HYZCardDetailMessageRequest alloc] init];
    
    messageRequest.delegate = self;
    
    [messageRequest getCardMessageRequest:urlString];
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

- (void)getCardMessageSuccess:(NSDictionary *)messageDictionary
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _detailModel = [[HYZCardDetailModel alloc] initWithDictionary:messageDictionary error:nil];
    
    [_cardDetailTableView reloadData];
}

- (void)getCardMessageFaild:(NSString *)faildString
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
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){return 4;}else{return 1;}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *cellIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = [NSString stringWithFormat:@"卡 号: %@",_detailModel.cardNo];
                break;
                case 1:
                cell.textLabel.text = [NSString stringWithFormat:@"姓 名: %@",_detailModel.name];
                break;
                case 2:
                cell.textLabel.text = [NSString stringWithFormat:@"卡样式: %@",_detailModel.cardType];
                break;
                case 3:
                cell.textLabel.text = [NSString stringWithFormat:@"电 话: %@",_detailModel.phone];
                break;
                
            default:
                break;
        }
    }
    else
    {
        [self creatTwoButton:(UITableViewCell *)cell];
    }
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

- (void)creatTwoButton:(UITableViewCell *)cell
{
//    解除绑定按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftButton.frame = CGRectMake(20, 2, 115, 40);
    
    [leftButton setTitle:@"解除绑定" forState:UIControlStateNormal];
    
    [leftButton setBackgroundColor:BACKGROUND_COLOR];
    
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:leftButton];
    
    
//    设为默认，取消默认
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightButton.frame = CGRectMake(155, 2, 115, 40);
    
    if ([_defaultString isEqualToString:@"0"]) {
        [_rightButton setTitle:@"设为默认" forState:UIControlStateNormal];
    }
    else{
        [_rightButton setTitle:@"取消默认" forState:UIControlStateNormal];
    }
    
    [_rightButton setBackgroundColor:BACKGROUND_COLOR];
    
    [_rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [_rightButton addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    [cell.contentView addSubview:_rightButton];
}

//解除绑定
- (void)leftButtonClicked
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    NSString *jiechuUrlString = [NSString stringWithFormat:@"%@vipeng/web/vi/unbindCard.do?username=%@&card=%@",URL_HTTP,[array objectAtIndex:0],_cardNumberString];
    
    HYZRelieveRequest *relieveRequest = [[HYZRelieveRequest alloc] init];
    
    relieveRequest.delegate = self;
    
    [relieveRequest relieveTheCardRequest:jiechuUrlString];
}

//设为默认、解除默认
- (void)rightButtonClicked
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    
    
    if ([_rightButton.titleLabel.text isEqualToString:@"设为默认"]) {
        NSString *defaultUrlString = [NSString stringWithFormat:@"%@vipeng/web/vi/updateCard.do?username=%@&cardno=%@&isdefault=1",URL_HTTP,[array objectAtIndex:0],_detailModel.cardNo];
        
        HYZSettingDefaultCardRequest *setDefaultRequest = [[HYZSettingDefaultCardRequest alloc] init];
        
        setDefaultRequest.delegate = self;
        
        [setDefaultRequest settingThisCardToDefaultReequest:defaultUrlString isDefaultString:@"1"];
    }
    else{
        NSString *defaultUrlString = [NSString stringWithFormat:@"%@vipeng/web/vi/updateCard.do?username=%@&cardno=%@&isdefault=0",URL_HTTP,[array objectAtIndex:0],_detailModel.cardNo];
        
        HYZSettingDefaultCardRequest *setDefaultRequest = [[HYZSettingDefaultCardRequest alloc] init];
        
        setDefaultRequest.delegate = self;
        
        [setDefaultRequest settingThisCardToDefaultReequest:defaultUrlString isDefaultString:@"0"];
    }
    

}

- (void)relieveRequestSuccess:(NSString *)successString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@"成功解除绑定"
                          
                          message:@""
                          
                          delegate:self
                          
                          cancelButtonTitle:@"确定"
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)relieveRequestFaild:(NSString *)faildString
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
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 
#pragma mark HYZSettingDefaultCardRequestDelegate -

- (void)settingSuccess:(NSString *)successString isDefaultString:(NSString *)defaultString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([defaultString isEqualToString:@"1"]) {
        [_rightButton setTitle:@"取消默认" forState:UIControlStateNormal];
    }else{
        [_rightButton setTitle:@"设为默认" forState:UIControlStateNormal];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
