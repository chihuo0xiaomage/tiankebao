//
//  HYZBalanceViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZBalanceViewController.h"

#import "MBProgressHUD.h"

#import "HYZGetCardDetailModel.h"

@interface HYZBalanceViewController ()

@end

@implementation HYZBalanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"余额积分";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _balanceTableView = [[UITableView alloc] initWithFrame:CGRectMake(15, 80, 290, 176)style:UITableViewStylePlain];
    
    _balanceTableView.delegate = self;
    
    _balanceTableView.dataSource = self;
    
    [self.view addSubview:_balanceTableView];
    
//    请求卡的详细信息
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    NSLog(@"=============%@", array);
    for (int i = 0; i < [array count]; i ++ ) {
        
            HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            HYZGetCardTokenRequest *getTokenRequest = [[HYZGetCardTokenRequest alloc] init];
            
            getTokenRequest.delegate = self;
            
            [getTokenRequest getCardToken:getCardModel.cardNo];
            
        }
    }
}

- (void)getCardTokenSuccess:(NSString *)token{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    HYZBalanceRequest *request = [[HYZBalanceRequest alloc] init];
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/cardYueJf.do?cardNo=%@&cardPwd=%@&token=%@",URL_HTTP,getCardModel.cardNo,getCardModel.cardPwd,token];
            
            request.delegate =self;
            
            [request getCardMessge:urlString];
        }
    }
    
}

- (void)getCardTokenFaild:(NSString *)faildString{
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_detailBalanceModel == nil){return 0;}else{return 4;}
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
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"沃商卡号: %@",_detailBalanceModel.cardNo];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"卡总余额: %@",_detailBalanceModel.totalMoney];

            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"可用金额: %@",_detailBalanceModel.consumeMoney];

            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"消费积分: %@",_detailBalanceModel.consumeJifen];

            break;
        default:
            break;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}

#pragma mark -
#pragma mark HYZBalanceRequestDelegate -

- (void)getCardMessageSuccess:(NSDictionary *)messageDic
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _detailBalanceModel  = [[HYZDetailBalanceModel alloc] initWithDictionary:messageDic error:nil];
    
    if (_detailBalanceModel) {
        [_balanceTableView reloadData];
    }
    else{}
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

- (void)wrongCard:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@""
                          
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
