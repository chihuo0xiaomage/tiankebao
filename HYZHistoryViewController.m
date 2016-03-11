//
//  HYZHistoryViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZHistoryViewController.h"

#import "MBProgressHUD.h"

#import "HYZGetCardDetailModel.h"

@interface HYZHistoryViewController ()

@end

@implementation HYZHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"消费历史";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _historyMessageArray = [[NSArray alloc] init];
    
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT - TABBAR_HEIGHT - NAVIGATION_HEIGHT) style:UITableViewStylePlain];
    
    _historyTableView.delegate = self;
    
    _historyTableView.dataSource = self;
    
    [self.view addSubview:_historyTableView];
    
//    请求获得消费历史
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    HYZGetCardTokenRequest *gettokenRequest = [[HYZGetCardTokenRequest alloc] init];
    
    gettokenRequest.delegate = self;
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            [gettokenRequest getCardToken:getCardModel.cardNo];
        }
    }
}

- (void)getCardTokenSuccess:(NSString *)token{
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    for (int i = 0; i < [array count]; i ++ ) {
        
        HYZGetCardDetailModel *getCardModel = [[HYZGetCardDetailModel alloc] initWithDictionary:[array objectAtIndex:i] error:nil];
        
        if ([getCardModel.isdefault isEqualToString:@"1"]) {
            
            NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/consumeMx.do?cardNo=%@&token=%@&startDate=2012-07-07&pageNumber=1&pageSize=100",URL_HTTP,getCardModel.cardNo,token];
            
            HYZHistoryRequest *request = [[HYZHistoryRequest alloc] init];
            
            request.delegate = self;
            
            [request getCardHistroyMessage:urlString];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_historyMessageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZHistoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier image:[UIImage imageNamed:@"ic_card_small.png"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    
    HYZHistoryDetailMessageModel *model = [[HYZHistoryDetailMessageModel alloc] initWithDictionary:[_historyMessageArray objectAtIndex:indexPath.row] error:nil];
    
    cell.dcardMoneyLable.text = [NSString stringWithFormat:@"消费: %@",model.DCARD_MONEY];
    
    cell.ddateLable.text = [NSString stringWithFormat:@"时间: %@",model.DDATE];
    
    cell.dshopnameLable.text = [NSString stringWithFormat:@"%@消费",model.DSHOPNAME];
    
    return cell;
}

#pragma mark -
#pragma mark HYZHistoryRequestDelegate -

- (void)getHistorySuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _historyMessageArray = messageArray;
    
    [_historyTableView reloadData];
}

- (void)getHistoryFaild:(NSString *)faildString
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
