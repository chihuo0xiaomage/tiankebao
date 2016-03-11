//
//  HYZSettlementViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSettlementViewController.h"

#import "mysql.h"

#import "HYZShoppingCarModel.h"

#import "SBJson.h"

#import "MBProgressHUD.h"

@interface HYZSettlementViewController ()

@property (nonatomic, strong) NSString   *tokenString;

@end

@implementation HYZSettlementViewController

@synthesize numberStr = _numberStr, priceStr = _priceStr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"快捷付款";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor =BACKGROUND_COLOR;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets= NO;}
    
    _messageArray = [[NSArray alloc] init];
    
    [self creatSubViews];
    
    [self valuationToMessageArray];
    
    [self creatsettlementTableView];
}

//创建上边、下边的view
- (void)creatSubViews
{
    HYZTopView *topView = [[HYZTopView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, 60)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    topView.numberLable.text = _numberStr;
    
    topView.priceLable.text = _priceStr;
    
    [self.view addSubview:topView];
    
    
    
    HYZDownView *downView = [[HYZDownView alloc] initWithFrame:CGRectMake(0,HEIGHT -TABBAR_HEIGHT - 109, WIDTH, 110)];
    downView.backgroundColor = [UIColor yellowColor];
    downView.delegate =self;
    
    [self.view addSubview:downView];
    
    [self creatsettlementTableView];
}

//创建表
- (void)creatsettlementTableView
{
    _settlementTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT + 61, WIDTH, HEIGHT - NAVIGATION_HEIGHT - 60 - 50 - 90) style:UITableViewStylePlain];
    
    _settlementTableView.dataSource = self;
    
    _settlementTableView.delegate = self;
    
    [self.view addSubview:_settlementTableView];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:indexPath.row];
    
    HYZSettlementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZSettlementCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.nameLable.text = messageModel.DNAME;
    
    cell.numberLable.text = messageModel.DNUMBER;
    
    cell.priceLable.text = messageModel.DPRICE;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

//    对全局的_messageArray进行赋值
- (void)valuationToMessageArray{
    _messageArray =(NSMutableArray *)[[mysql shareMysql] show:[NSString stringWithFormat:@"select * from ShoppingCarTableView"]];
    
    [_settlementTableView reloadData];
}

- (void)sure:(NSString *)cardNumber
{
    if ([cardNumber isEqual:[NSNull null]] || cardNumber == nil) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  
                                  initWithTitle:@"您尚未选择付款卡"
                                  
                                  message:@"请选择付款卡"
                                  
                                  delegate:nil
                                  
                                  cancelButtonTitle:@"确定"
                                  
                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    else{
        MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = NSLocalizedString(@"加载中...", nil);
        
        _cardNumberStr = cardNumber;
        
        HYZGetCardTokenRequest *tokenReuqest = [[HYZGetCardTokenRequest alloc] init];
        
        tokenReuqest.delegate =self;
        
        [tokenReuqest getCardToken:cardNumber];
    }
}

#pragma mark -
#pragma mark HYZGetCardTokenRequestDelegate -

- (void)getCardTokenSuccess:(NSString *)token
{
    _tokenString = token;
    
    HYZBalanceRequest *request = [[HYZBalanceRequest alloc] init];
    
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/cardYueJf.do?cardNo=%@&cardPwd=MTIzNDU2&token=%@",URL_HTTP,_cardNumberStr,token];
    request.delegate =self;
    
    [request getCardMessge:urlString];
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

#pragma mark -
#pragma mark HYZBalanceRequestDelegate -

- (void)getCardMessageSuccess:(NSDictionary *)messageDic
{
    HYZDetailBalanceModel *detailBalanceModel  = [[HYZDetailBalanceModel alloc] initWithDictionary:messageDic error:nil];
    
    if (detailBalanceModel) {
        if ([detailBalanceModel.consumeMoney floatValue] > [_priceStr floatValue]) {
            
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
            
            NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
            
            
            NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (int i = 0; i < [_messageArray count]; i ++) {
                
                HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:i];
                
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:messageModel.DBARCODE,@"DBARCODE",messageModel.DPRICE,@"DPRICE",messageModel.DNUMBER,@"DNUM", nil];
                
                [mutableArray addObject:dic];
            }
            
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:mutableArray,@"shopbean",nil];
            
            
            SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
            
            NSString *jsonStr = [jsonWriter stringWithObject:dic];
            
            NSString *urlString = [[NSString stringWithFormat:@"%@vipeng/web/shop/shop_detile.do?shopbeans=%@&subshop=0001&username=%@",URL_HTTP,jsonStr,[array objectAtIndex:0]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            HYZShopDetailRequest *request = [[HYZShopDetailRequest alloc] init];
            
            request.delegate =self;
            
            [request shopDetailSentRequest:urlString];
        }
        else{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            UIAlertView *alertView = [[UIAlertView alloc]
                                      
                                      initWithTitle:@"对不起"
                                      
                                      message:@"您的卡上余额不足"
                                      
                                      delegate:nil
                                      
                                      cancelButtonTitle:@"确定"
                                      
                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
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

#pragma mark -
#pragma mark HYZShopDetailRequestDelegate -

- (void)shopDetailSentSuccess:(NSString *)successString
{
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/saveConsume.do?cardNo=%@&cardPwd=%@&money=%@&token=%@&transactionNo=%@",URL_HTTP,_cardNumberStr,@"MTIzNDU2",_priceStr,_tokenString,successString];
    
    HYZSaveConsumeRequest *savaConsumeRequest = [[HYZSaveConsumeRequest alloc] init];
    
    savaConsumeRequest.delegate = self;
    
    [savaConsumeRequest commitConsumeMessageRequest:urlString barCode:successString];
}

#pragma mark -
#pragma mark HYZSaveConsumeRequestDelegate -

- (void)requestSuccess:(NSString *)successString barCode:(NSString *)barCode
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/shop/shop_commit.do?pno=%@&cardno=%@&pmoney=%@&username=%@",URL_HTTP,barCode,_cardNumberStr,_priceStr,[array objectAtIndex:0]];
    
    HYZShoppCommitRequest *shopCommitRequest = [[HYZShoppCommitRequest alloc] init];
    
    shopCommitRequest.delegate = self;
    
    [shopCommitRequest commitShopMessageRequest:urlString barCode:barCode];
}

- (void)requestError:(NSString *)errorString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:errorString
                          
                          message:@""
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
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
#pragma mark HYZShoppCommitRequestDelegate -

- (void)commitSuccess:(NSString *)successString barCode:(NSString *)barCode
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if ([successString isEqualToString:@"支付成功"]) {
        HYZSureViewController *sureViewController = [[HYZSureViewController alloc] init];
        
        sureViewController.barCodeNUmberString = barCode;
        
        sureViewController.allNumberString = _numberStr;
        
        sureViewController.moneyString = _priceStr;
        
        [self.navigationController pushViewController:sureViewController animated:YES];
    }
    else{[MBProgressHUD hideHUDForView:self.view animated:YES];}
}

- (void)commitFaild:(NSString *)faildString
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
