//
//  HYZMoneyChangeViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMoneyChangeViewController.h"

#import "MBProgressHUD.h"

#import "HYZGetCardDetailModel.h"

@interface HYZMoneyChangeViewController ()

@end

@implementation HYZMoneyChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"金额变动";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _moneyChangeArray = [[NSArray alloc] init];
    
    _moneyChangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 49 - 64) style:UITableViewStylePlain ];
    
    _moneyChangeTableView.delegate = self;
    
    _moneyChangeTableView.dataSource = self;
    
    [self.view addSubview:_moneyChangeTableView];
    
    
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
            
            NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/money.do?cardNo=%@&token=%@&startDate=2012-07-07&pageNumber=1&pageSize=100",URL_HTTP,getCardModel.cardNo,token];
            
            HYZMoneyChangeRequest *request = [[HYZMoneyChangeRequest alloc] init];
            
            request.delegate =self;
            
            [request getMoneyChangeMessage:urlString];
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
    return [_moneyChangeArray count];
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
    
    HYZMoneyChangeDetailModel *model = [[HYZMoneyChangeDetailModel alloc] initWithDictionary:[_moneyChangeArray objectAtIndex:indexPath.row] error:nil];
    
    cell.dcardMoneyLable.text = [NSString stringWithFormat:@"%@: %@%@",model.DCHANGE_TYPE,model.DPAYMODE,model.DCHANGE_MONEY];
    
    cell.ddateLable.text = [NSString stringWithFormat:@"时间: %@",model.DDATE];
    
    cell.dshopnameLable.text = [NSString stringWithFormat:@"%@%@",model.DSHOPNAME,model.DCHANGE_TYPE];
    
    return cell;
}

- (void)getMoneyChangeMessageSuccess:(NSArray *)messageArray
{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _moneyChangeArray = messageArray;
    
    [_moneyChangeTableView reloadData];
}

- (void)getMoneyChangeMessageFaild:(NSString *)faildString
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
