//
//  HYZQueruTheElectronicTicketViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZQueruTheElectronicTicketViewController.h"

#import "MBProgressHUD.h"

#import "HYZGetCardDetailModel.h"

@interface HYZQueruTheElectronicTicketViewController ()

@end

@implementation HYZQueruTheElectronicTicketViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"电子券";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = BACKGROUND_COLOR;
    
    _messageArray = [[NSArray alloc] init];
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 49 - 64)style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
    
    [self getCardToken];
}

- (void)getCardToken
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    HYZGetCardTokenRequest *getCardTokenRequest = [[HYZGetCardTokenRequest alloc] init];
    
    getCardTokenRequest.delegate = self;
    
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            [getCardTokenRequest getCardToken:getCardModel.cardNo];
        }
    }
}

#pragma mark -
#pragma mark HYZGetCardTokenRequestDelegate -

    //成功获取token
- (void)getCardTokenSuccess:(NSString *)token
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/dzq.do?cardNo=%@&startDate=2012-07-07&pageNumber=1&pageSize=100&token=%@",URL_HTTP,getCardModel.cardNo,token];
            
            HYZQueryTheElectronicTicketRequest *request = [[HYZQueryTheElectronicTicketRequest alloc] init];
            
            request.delegate = self;
            
            [request getElectronicMessageRequest:urlString];
        }
    }
}

    //获取token失败
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

#pragma mark -
#pragma mark HYZQueryTheElectronicTicketRequestDelegate -

- (void)getMessageSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _messageArray = messageArray;
    
    [_myTableView reloadData];
}

- (void)getMessageFaild:(NSString *)faildString
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZHistoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier image:[UIImage imageNamed:@"ic_card_small.png"]];
    }
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            cell.cardNoLable.text = getCardModel.cardNo;
        }
    }
    
    HYZQueryTheElectronicTicketDataListModel *model = [[HYZQueryTheElectronicTicketDataListModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];
    
    cell.dcardMoneyLable.text = [NSString stringWithFormat:@"交易: %@",model.DCARD_MONEY];
    
    cell.ddateLable.text = [NSString stringWithFormat:@"时间: %@",model.DDATE];
    
    cell.dshopnameLable.text = [NSString stringWithFormat:@"%@交易",model.DSHOPNAME];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
