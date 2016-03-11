//
//  HYZMineViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZMineViewController.h"

#import "MBProgressHUD.h"

@interface HYZMineViewController ()

@end

@implementation HYZMineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        self.tabBarItem.title = @"我的";
//        
        self.navigationItem.title = @"我的";
        
        self.tabBarItem.image = [UIImage imageNamed:@"icon_5_n.png"];
        
        NSString* newMessageString = [[NSUserDefaults standardUserDefaults] objectForKey:@"NewMessage"];
        if (newMessageString) {
            self.tabBarItem.badgeValue = @"new";
        }else{}
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getCardRequest];
    
    if (IOS7){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIBarButtonItem *rightBar  = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStyleBordered target:self action:@selector(rightItemClicked:)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    _cardArray = [[NSArray alloc] init];
    
    _itemArray = [[NSArray alloc] initWithObjects:@"快购历史",@"我的日历",@"我的消息",@"我的卡包", nil];
    
    _itemTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 74, 300, HEIGHT - NAVIGATION_HEIGHT - 59)];
    _itemTableView.tableFooterView = [[UIView alloc]init];
    _itemTableView.dataSource = self;
    _itemTableView.delegate = self;
    [self.view addSubview:_itemTableView];
}

- (void)getCardRequest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/getCard.do?username=%@",URL_HTTP,[array objectAtIndex:0]];
    
    HYZGetCardRequest *request = [[HYZGetCardRequest alloc] init];
    request.delegate =self;
    [request getCardRequest:urlString];
}

#pragma mark -
#pragma mark HYZGetCardRequestDelegate -

- (void)getUserCardSuccess:(NSArray *)cardArray{
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _cardArray = cardArray;
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
    
    [[NSFileManager defaultManager] removeItemAtPath:@"CARD.plist" error:nil];
    
    if (!docDir) {
            //NSLog(@"Documents 目录未找到");
    }
    NSString *filePath = [docDir stringByAppendingPathComponent:@"CARD.plist"];
    
    [cardArray writeToFile:filePath atomically:YES];
    
    [_itemTableView reloadData];
    
}

- (void)requestFaild:(NSString *)faildString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"请检查您的网络设置"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){return 80;} else {return 44;}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){return 1;} else {return [_itemArray count];}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
        
        HYZGetCardDetailModel *model = nil;
        
        NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
        if ([_cardArray count]>0) {
            model = [[HYZGetCardDetailModel alloc] initWithDictionary:[_cardArray objectAtIndex:0] error:nil];
        }
        if ([model.isdefault isEqualToString:@"1"]) {
            HYZMineCell *cell = [[HYZMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil headPortraitImage:@"Icon.png" userName:[array objectAtIndex:0]CardNumber:model.cardNo];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.selected = NO;
            
            return cell;
        }else{
            HYZMineCell *cell = [[HYZMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil headPortraitImage:@"xiaoxi-1.png" userName:[array objectAtIndex:0]CardNumber:@"尚未设置默认卡"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.selected = NO;
            
            return cell;
        }
    }
    else
    {
        static NSString *cellIdentifier = @"CellIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [_itemArray objectAtIndex:indexPath.row];
    
        return cell;}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
            {
                [self.navigationController pushViewController:[[HYZQBuyHistoryViewController alloc] init] animated:YES];
            }
                break;
            case 1:
            {
                [self.navigationController pushViewController:[[HYZMyCalendarViewController alloc] init] animated:YES];
            }
                break;
            case 2:
            {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"NewMessage"];
            
                self.tabBarItem.badgeValue = nil;
            
                [self.navigationController pushViewController:[[HYZMyMessageViewController alloc] init] animated:YES];
            }
                break;
                case 3:
            {
                [self.navigationController pushViewController:[[HYZMyCardBagViewController alloc] init] animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    else{return;}
}

- (void)rightItemClicked:(UIBarButtonItem *)sender
{
    [self.navigationController pushViewController:[[HYZSettingViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
