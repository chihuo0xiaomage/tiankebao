//
//  HYZTopUpViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZTopUpViewController.h"

#import "MBProgressHUD.h"

#import "NSString+Base64.h"
//
//#import "AlixPayOrder.h"
//#import "AlixLibService.h"
#import "AlixPayResult.h"

#import "AlipayHeader.h"

#import "PartnerConfig.h"
#import "DataVerifier.h"
@interface HYZTopUpViewController ()
@property(nonatomic,strong)Order *order;
@end

@implementation HYZTopUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"充值";
    }
    return self;
}

//- (void)TopUpSuccess
//{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          
//                          initWithTitle:@"交易成功"
//                          
//                          message:nil
//                          
//                          delegate:nil
//                          
//                          cancelButtonTitle:@"确定 "
//                          
//                          otherButtonTitles:nil, nil];
//    [alert show];
//}
//
//- (void)TopUpFaild
//{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          
//                          initWithTitle:@"交易失败"
//                          
//                          message:@"取消付款或金额不在充值范围内"
//                          
//                          delegate:nil
//                          
//                          cancelButtonTitle:@"确定 "
//                          
//                          otherButtonTitles:nil, nil];
//    [alert show];
//}

//由本地时间生成一个序列号
- (NSString *)generateTradeNO
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSSSSS"];
    
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    
	return time;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        //__result = @selector(paymentResult:);
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [self creatUI];
    
    [self getTopUpRequest];
}

- (void)getTopUpRequest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@/card/open/api/getValueRange.do?cardNo=%@&czfaNo=%@&token=%@",URL_HTTP,_cardNumberString,_DFANOString,_cardTokenString];
    
    HYZTopUpRequest *topUpRequest = [[HYZTopUpRequest alloc] init];
    
    topUpRequest.delegate = self;
    
    [topUpRequest getTheScopeOfMoneyRequest:urlString];
}

- (void)creatUI
{
//    卡号
    HYZLoginTextView *cardNumberTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 80, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    cardNumberTextView.textField.userInteractionEnabled = NO;
    
    cardNumberTextView.textField.text = _cardNumberString;
    
    [self.view addSubview:cardNumberTextView];
    
    
//    充值方案
    HYZLoginTextView *planTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 130, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    planTextView.textField.userInteractionEnabled = NO;
    
    planTextView.textField.text = [NSString stringWithFormat:@"%@ : %@",_DFANAMEString,_DFANOString];
    
    planTextView.textField.font = [UIFont systemFontOfSize:16];
    
    [self.view addSubview:planTextView];
    
    
//    赠送类型
    HYZLoginTextView *typeTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 180, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    typeTextView.textField.userInteractionEnabled = NO;
    
    typeTextView.textField.text = _typeString;
    
    [self.view addSubview:typeTextView];
    
    
//    赠送明细
    HYZLoginTextView *detailTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 230, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:nil];
    
    detailTextView.textField.userInteractionEnabled = NO;
    
    detailTextView.textField.text = _detailString;
    
    [self.view addSubview:detailTextView];
    
    
    
//    充值金额
    _moneyTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 280, 290, 35) leftImageName:@"main_icon_username.png" placeholderString:@""];
    
    _moneyTextView.textField.font = [UIFont systemFontOfSize:16];
    
    _moneyTextView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_moneyTextView];
    
    
//    密码
    _pswTextView = [[HYZLoginTextView alloc] initWithFrame:CGRectMake(15, 330, 290, 35) leftImageName:@"main_icon_mima.png" placeholderString:@"输入卡密码"];
    
    _pswTextView.textField.secureTextEntry = YES;
    
    _pswTextView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_pswTextView];
    
    
//    充值按钮
    UIButton *topUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    topUpButton.frame = CGRectMake(20, 380, 280, 40);
    
    topUpButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [topUpButton setTitle:@"充值" forState:UIControlStateNormal];
    
    [topUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [topUpButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [topUpButton addTarget:self action:@selector(topUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:topUpButton];
}

- (void)topUpButtonClick
{
//    判断该卡的金额充值范围
    
    _opinion = [[HYZOpinion alloc] init];
    
    _opinion.delegate = self;
    
    [_opinion opinionRangeOfMoney:_moneyTextView.textField.text minValue:_minValueString maxValur:_maxValueString];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_moneyTextView.textField resignFirstResponder];
    
    [_pswTextView.textField resignFirstResponder];
}

-(NSString*)getOrderInfo
{
   // AlixPayOrder *order = [[AlixPayOrder alloc] init];
   _order = [[Order alloc]init];
    _order.partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    
    _order.seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    
    //订单ID（由商家自行制定）
    _order.tradeNO = [self generateTradeNO];
    
    _transactionNumberString = _order.tradeNO;
    
    [self saveMessage];
        
    //商品标题
	_order.productName = @"充值";
    
    //商品描述
	_order.productDescription = @"送积分";
    
     //商品价格
	_order.amount = [NSString stringWithFormat:@"%@",_moneyTextView.textField.text];
    
     //回调URL
	_order.notifyURL =  @"http://www.woshang88.com";
	
	return [_order description];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA private key"]);
    
    NSString *signedString = [signer signString:orderInfo];
    
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
//    NSLog(@"result = %@",result);
}

#pragma mark -
#pragma mark HYZOpinionCardRequestDelegate -

- (void)opinionSuccess:(NSString *)messageString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    NSString *partner = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Partner"];
    
    NSString *seller = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Seller"];
    
    if ([partner length] == 0 || [seller length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              
                              message:@"缺少partner或者seller。"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil];
        [alert show];
        return;
    }else{
       NSString *appScheme = @"BaoYuanWeiPeng";
        
      NSString* orderInfo = [self getOrderInfo];
        
       NSString* signedStr = [self doRsa:orderInfo];
        
       // 将签名成功字符串格式化为订单字符串
     NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderInfo, signedStr, @"RSA"];
        
  // [AlipayRequestConfig alipayWithPartner:kPartnerID seller:kSellerAccount tradeNO:_transactionNumberString productName:_order.productName productDescription:_order.description amount:_order.amount notifyURL:kNotifyURL itBPay:_order.itBPay];
        [[AlipaySDK defaultService]payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);

        }];
        
      // [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];

    }
}
-(void)paymentResult:(NSString *)resultd
{
        //NSLog(@"resultd = %@", resultd);
        //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
	if (result)
        {
		if (result.statusCode == 9000)
            {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
                //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
                {
                    //验证签名成功，交易结果无篡改
                }
            }
        else
            {
                //交易失败
            }
        }
    else
        {
            //失败
        }
    
}

- (void)opinionFalse:(NSString *)falseString{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:falseString
                          
                          message:@"确认您的密码"
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark -
#pragma mark HYZOpinionDelegate -

- (void)passOpinion:(NSString *)moneyString{
//    验证卡号密码
    [_opinion opinionPassWorld:_pswTextView.textField.text];
}

- (void)pass{
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    HYZOpinionCardRequest *request = [[HYZOpinionCardRequest alloc] init];
    
    request.delegate = self;
    
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/validCard.do?cardNo=%@&cardPwd=%@&token=%@",URL_HTTP,_cardNumberString,[_pswTextView.textField.text base64EncodedString],_cardTokenString];
    
    [request opinionCardRequest:urlString];
    
}

- (void)opinionFaild:(NSString *)faildString{
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:nil
                          
                          delegate:nil
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark -
#pragma mark HYZTopUpRequestDelegate -

- (void)getTopUpMessageSuccess:(NSString *)maxValueString message:(NSString *)messageString minValue:(NSString *)minValueString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _moneyTextView.textField.placeholder =[NSString stringWithFormat:@"输入%@-%@之间的整数金额",minValueString,maxValueString];
    
    _minValueString = minValueString;
    
    _maxValueString = maxValueString;
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:faildString
                          
                          message:@"请检查您的网络设置"
                          
                          delegate:self
                          
                          cancelButtonTitle:@"确定 "
                          
                          otherButtonTitles:nil, nil];
    
    alert.tag = 111;
    
    [alert show];
}

- (void)saveMessage
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (!docDir) { NSLog(@"Documents 目录未找到");}
    
    NSDictionary *messageDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                _cardNumberString,@"cardNo",
                                [_pswTextView.textField.text base64EncodedString],@"cardPwd",
                                _moneyTextView.textField.text,@"money",
                                _DFANOString,@"czfaNo",
                                _typeString,@"zsType",
                                _detailString,@"zsMx",
                                _cardTokenString,@"token",
                                _transactionNumberString,@"transactionNo",
                                nil];

    NSString *filePath = [docDir stringByAppendingPathComponent:@"TopUpMessage.Plist"];
    
    [messageDic writeToFile:filePath atomically:YES];
    
}

#pragma mark -
#pragma mark UIAlertViewDelete -

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}else if (alertView.tag == 111){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
////        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
