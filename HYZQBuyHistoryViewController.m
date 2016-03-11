//
//  HYZQBuyHistoryViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZQBuyHistoryViewController.h"

#import "MBProgressHUD.h"

@interface HYZQBuyHistoryViewController ()

@end

@implementation HYZQBuyHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"快购历史";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7) {self.automaticallyAdjustsScrollViewInsets = NO;}
    
    [self creatHistoryTableView];
    
    _messageArray = [[NSArray alloc] init];
    
    [self getUserShoppingMessageRequest];
}

- (void)getUserShoppingMessageRequest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/shop/shop_list.do?pageNumber=1&pageSize=1000&username=%@",URL_HTTP,[array objectAtIndex:0]];
    
    HYZQ_BuyHistoryRequest *historyRequest = [[HYZQ_BuyHistoryRequest alloc] init];
    
    historyRequest.delegate = self;
    
    [historyRequest getUserShoppingMessageRequest:urlString];
    
}

- (void)creatHistoryTableView
{
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT-NAVIGATION_HEIGHT-TABBAR_HEIGHT) style:UITableViewStylePlain];
    
    _historyTableView.tableFooterView = [[UIView alloc]init];
    
    _historyTableView.delegate = self;
    
    _historyTableView.dataSource = self;
    
    [self.view addSubview:_historyTableView];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZQBuyDetailModel *model = [[HYZQBuyDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];
    
    HYZQBuyHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZQBuyHistoryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.barCodeLable.text = [NSString stringWithFormat:@"【交易单号】 %@",model.barcode];
    
    cell.moneyLable.text = [NSString stringWithFormat:@"【金额】 %@",model.pmoney];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createDate/1000];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *createDate = [dateFormat stringFromDate: date];
    
    cell.timeLable.text = [NSString stringWithFormat:@"【时间】 %@",createDate];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    HYZQBuyDetailModel *model = [[HYZQBuyDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];
    
    HYZHisToryDetailViewController *detailViewController = [[HYZHisToryDetailViewController alloc] init];
    
    detailViewController.barCodeString = model.barcode;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark HYZQ_BuyHistoryRequestDelegate -

- (void)historyRequestSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _messageArray = messageArray;
    
    [_historyTableView reloadData];
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"请检查您的网络设置"
                              
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
