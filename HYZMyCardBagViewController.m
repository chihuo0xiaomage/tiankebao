//
//  HYZMyCardBagViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMyCardBagViewController.h"

#import "MBProgressHUD.h"

@interface HYZMyCardBagViewController ()

@end

@implementation HYZMyCardBagViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"卡包";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getUserAllCard];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatATableView];
}

- (void)creatATableView
{
    if (IOS7) {self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _cardBagTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    
    _cardBagTableView.tableFooterView = [[UIView alloc]init];
    
    _cardBagTableView.delegate = self;
    
    _cardBagTableView.dataSource = self;
    
    [self.view addSubview:_cardBagTableView];
}

- (void)getUserAllCard
{
//    从沙盒取出用户信息
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/getCard.do?username=%@",URL_HTTP,[array objectAtIndex:0]];
    
    HYZCardBagRequest *cardBagRequest = [[HYZCardBagRequest alloc] init];
    
    cardBagRequest.delegate = self;
    
    [cardBagRequest getUserAllCardRequest:urlString];
    
}

#pragma mark - 
#pragma mark HYZCardBagRequestDelegate -

- (void)getInfoSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _messageArray = messageArray;
    
    [_cardBagTableView reloadData];
}

- (void)getInfoFaild:(NSString *)faildString
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (_messageArray == nil) {
            return 0;
        }else{
            return [_messageArray count];}
    }
    else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (indexPath.section == 0)
    {
        HYZCardBagMessageModel *model = [[HYZCardBagMessageModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];

        if ([model.isdefault isEqualToString:@"0"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        cell.textLabel.text = model.cardNo;
    }
    else{
        cell.textLabel.text = @"                  添加绑定卡";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 0) {
        HYZCardDetailViewController *cardMessageViewController = [[HYZCardDetailViewController alloc] init];
        
        HYZCardBagMessageModel *model = [[HYZCardBagMessageModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];

        cardMessageViewController.cardNumberString = model.cardNo;
        
        cardMessageViewController.defaultString = model.isdefault;
        
        [self.navigationController pushViewController:cardMessageViewController animated:YES];
    }
    else
    {
        [self.navigationController pushViewController:[[HYZAddCardViewController alloc] init] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
