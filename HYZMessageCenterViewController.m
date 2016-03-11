//
//  HYZMessageCenterViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMessageCenterViewController.h"

#import "UIImageView+WebCache.h"

#import "MBProgressHUD.h"

@interface HYZMessageCenterViewController ()

@end

@implementation HYZMessageCenterViewController

@synthesize codeString = _codeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"商家信息";
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self sendRequest];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatMessageTableView];
}

- (void)creatMessageTableView
{
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64 - 49) style:UITableViewStylePlain];
    
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _messageTableView.delegate = self;
    
    _messageTableView.dataSource = self;
    
    [self.view addSubview:_messageTableView];
}

- (void)sendRequest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    _messageArray = [[NSArray alloc] init];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/message/getUserMsg.do?username=%@&tenantcode=%@&pageNumber=1&pageSize=100",URL_HTTP,[array objectAtIndex:0],_codeString];
    
    HYZGetAllMessageRequest *getRequest = [[HYZGetAllMessageRequest alloc] init];
    
    getRequest.delegate = self;
    
    [getRequest getAllMessageRequest:urlString];
}

#pragma mark -
#pragma mark TableViewDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _messageModel = [[HYZMessageDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:[_messageArray count] - indexPath.row - 1] error:nil];
    
    int messageType = [_messageModel.messageType intValue];
    
    CGSize contentSize=[_messageModel.message sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(270, 1000) lineBreakMode:UILineBreakModeWordWrap];
    if (messageType == 8) {return 300;}
    
    else if (messageType == 0){return 60+contentSize.height;}
    
    else{return 80 + contentSize.height;}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZDMMessageCell *cell = nil;
    
    _messageModel = [[HYZMessageDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:[_messageArray count] - indexPath.row - 1] error:nil];
    
    int messageType = [_messageModel.messageType intValue];
    
    CGSize contentSize=[_messageModel.message sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(270, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    if (!cell)
    {
        if (messageType == 8) {
            cell = [[HYZDMMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier image:[UIImage imageNamed:@"bg_xx.png"] tag:[NSString stringWithFormat:@"%lu",[_messageArray count] - indexPath.row - 1] height:300 messageType:messageType];
            
            cell.cellDelegate = self;
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.selected = NO;
        }
        else if (messageType == 0){
            cell = [[HYZDMMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier image:[UIImage imageNamed:@"bg_xx.png"] tag:[NSString stringWithFormat:@"%lu",[_messageArray count] - indexPath.row - 1] height:contentSize.height + 60 messageType:messageType];

            cell.cellDelegate = self;
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.selected = NO;
        }
        else{
            cell = [[HYZDMMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier image:[UIImage imageNamed:@"bg_xx.png"] tag:[NSString stringWithFormat:@"%lu",[_messageArray count] - indexPath.row - 1] height:80 + contentSize.height messageType:messageType];
            
            cell.cellDelegate = self;
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            cell.selected = NO;
        }
    }
    if (messageType == 8) {
//        消息标题
        cell.titleLable.text = _messageModel.title;
        
//        消息内容
        cell.messageLable.text = _messageModel.message;
        
        NSURL *urlString = [NSURL URLWithString:[NSString stringWithFormat:@"%@vipeng/%@",URL_HTTP,_messageModel.uri]];
        
        [cell.dmImageView setImageWithURL:urlString placeholderImage:[UIImage imageNamed:@"sina_weibo.png"]];
        
//        发布日期
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_messageModel.createDate doubleValue]/1000];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        NSString *createDate = [dateFormat stringFromDate: date];
        
        cell.createDateLable.text = createDate;
        
//        商户
        cell.tenantcodeLable.text = _messageModel.tenantcode;
    }
    else if (messageType == 0){
        cell.titleLable.text = _messageModel.title;
        
        cell.messageLable.text = _messageModel.message;
        
//        发布日期
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_messageModel.createDate doubleValue]/1000];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        NSString *createDate = [dateFormat stringFromDate: date];
        
        cell.createDateLable.text = createDate;
        
//        商户
        cell.tenantcodeLable.text = _messageModel.tenantcode;
    }
    else{
        cell.titleLable.text = _messageModel.title;
        
        cell.messageLable.text = _messageModel.message;
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_messageModel.createDate doubleValue]/1000];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        NSString *createDate = [dateFormat stringFromDate: date];
        
        cell.createDateLable.text = createDate;
        
        cell.tenantcodeLable.text = _messageModel.tenantcode;
        
        if ([_messageModel.isPingjia intValue] == 0) {
            cell.pingjiaLale.hidden = NO;
        }
        else{
            cell.pingjiaLale.hidden =YES;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

#pragma mark -
#pragma mark HYZGetAllMessageRequestDelegate -

- (void)getUserMessageSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _messageArray = messageArray;
    
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

#pragma mark -
#pragma mark HYZDMMessageCellDelegate -

- (void)backgroundImageClick:(NSString *)tag;
{
    _messageModel = [[HYZMessageDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:[tag intValue]] error:nil];
    
    int messageType = [_messageModel.messageType intValue];
    
    int pingjia = [_messageModel.isPingjia intValue];
    
    if (messageType == 1 && pingjia == 0){
        HYZCommentViewController *commentViewController = [[HYZCommentViewController alloc] init];
        
        commentViewController.message_idString = _messageModel.message_id;
        
        commentViewController.tenantCodeString = _messageModel.tenantcode;
        
        [self.navigationController pushViewController:commentViewController animated:YES];
    }
    else if (messageType == 8){
        HYZDMMessageViewController *dmMessageViewController = [[HYZDMMessageViewController alloc] init];
        
        dmMessageViewController.idString = _messageModel.message_id;
        
        [self.navigationController pushViewController:dmMessageViewController animated:YES];
    }
    else{
        return;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
