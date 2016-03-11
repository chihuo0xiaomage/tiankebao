//
//  HYZMyMessageViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMyMessageViewController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

@interface HYZMyMessageViewController ()

@end

@implementation HYZMyMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"消息";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getUserMessageRequest];
    
    _messageArray = [[NSArray alloc] init];
    
    _hasArray = [[NSArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatMessageTableView];
}

- (void)creatMessageTableView
{
    if (IOS7) {self.automaticallyAdjustsScrollViewInsets = NO; }
    
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT - TABBAR_HEIGHT - NAVIGATION_HEIGHT) style:UITableViewStylePlain];

    _messageTableView.tableFooterView = [[UIView alloc]init];
    _messageTableView.dataSource = self;
    
    _messageTableView.delegate = self;
    
    [self.view addSubview:_messageTableView];
}

// 判断是否有新消息
- (void)newMessgeRequestUserName:(NSString *)aString
{
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/message/new_code.do?username=%@",URL_HTTP,aString];
    
    [_request messageRequest:urlString];
}

//查看用户都绑定了哪些卡
- (void)getUserMessageRequest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    _request = [[HYZMessageRequest alloc] init];
    
    _request.delegate = self;
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/vi/getMerchant.do?username=%@",URL_HTTP,[array objectAtIndex:0]];
    
    [_request UserCardMessageRequest:urlString userName:[array objectAtIndex:0]];
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

    HYZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@vipeng/%@",URL_HTTP,[[_messageArray objectAtIndex:indexPath.row] objectForKey:@"shop_head"]]];
    
    [cell.leftImageView setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"sina_weibo.png"]];
    
    cell.shopNameLable.text = [[_messageArray objectAtIndex:indexPath.row] objectForKey:@"groupName"];
    
    for (int i = 0 ; i < [_hasArray count]; i ++) {
        if ([[[_messageArray objectAtIndex:indexPath.row] objectForKey:@"tenantCode"] isEqualToString:[[_hasArray objectAtIndex:i] objectForKey:@"tenantCode"]]){
            cell.rightImageView.image = [UIImage imageNamed:@"new_message.png"];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/message/read_msg.do?username=%@&tenantcode=%@",URL_HTTP,[array objectAtIndex:0],[[_messageArray objectAtIndex:indexPath.row] valueForKey:@"tenantCode"]];
    
    HYZReadMessageRequest *readRequest = [[HYZReadMessageRequest alloc] init];
    
    readRequest.delegate = self;
    
    [readRequest readMessageRequest:urlString codeString:[[_messageArray objectAtIndex:indexPath.row] valueForKey:@"tenantCode"]];
}

#pragma mark -
#pragma mark HYZMessageRequestDelegate -

- (void)getUserCardMessageSuccess:(NSArray *)messageArray userName:(NSString *)aString
{
    [self newMessgeRequestUserName:aString];
    
    _messageArray = messageArray;
}

- (void)getMessageSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _hasArray = messageArray;
    
    [_messageTableView reloadData];
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

- (void)readMessageSuccess:(NSString *)successString codeString:(NSString *)code
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([successString isEqualToString:@"更新成功"]) {
        HYZMessageCenterViewController *messageCenterViewController = [[HYZMessageCenterViewController alloc] init];
        
        messageCenterViewController.codeString = code;
        
        [self.navigationController pushViewController:messageCenterViewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
