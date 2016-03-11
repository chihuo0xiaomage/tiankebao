//
//  BYAlipay.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYAlipay.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
//#import "AlixPayOrder.h"
//#import "AlixLibService.h"
#import "AlipayHeader.h"
#import "Encrypt.h"
#import "NetWorking.h"
static NSString * const PaySucceful = @"PaySucceful";
@implementation BYAlipay
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PaySucceful object:nil];
}
- (void)paySucceful:(NSNotification *)notification
{
    NSData * data = [notification object];
    if (data != NULL) {
       NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if ([[dic objectForKey:@"resultCode"] integerValue] == 0) {
            [[[UIAlertView alloc] initWithTitle:@"付款成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
    
}
- (void)changeOrderResults
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paySucceful:) name:PaySucceful object:nil];

        CGFloat time = [Encrypt timeInterval];
        NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.product.order.paylog.modity&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&orderSn=%@&memberId=%@", time, [_shopDic objectForKey:@"orderSn"], MEMBERID];
        //                    //进行加密
        NSString * sign = [Encrypt generate:keyValues];
        NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        //                    //开始网络请求
        [NetWorking NetWorkingURL:urlStr target:self action:nil identifier:PaySucceful];
}
- (void)paymentResult:(NSString *)resultd
{
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
    if (result)
        {
		if (result.statusCode == 9000){
			/*
			 *用公钥验证签名 严格验证请使用result.resultString與result.signString验签
			 */
            
                //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
                {
                [self changeOrderResults];
                    //验证签名成功，交易结果无篡改
                }
            }else{
            [[[UIAlertView alloc] initWithTitle:@"用户取消交易" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
                //交易失败
            }
        }else{
        [[[UIAlertView alloc] initWithTitle:nil message:@"交易失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            //失败
        }
}
- (void)startPayMoney:(NSMutableDictionary *)dic
{
    self.shopDic = dic;
    NSString * appScheme = @"WeiPeng";
    NSString * orderInfo = [self getOrderInfo:dic];
    NSString * signedStr = [self doRsa:orderInfo];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
  // [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
  //   [AlipayRequestConfig alipayWithPartner:_order.partner seller:_order.seller tradeNO:_order.tradeNO productName:_order.productName productDescription:_order.productDescription amount:_order.amount notifyURL:_order.notifyURL itBPay:_order.itBPay];
    
    [[AlipaySDK defaultService]payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
         NSLog(@"reslut = %@",resultDic);
    }];
   
}
- (NSString *)getOrderInfo:(NSMutableDictionary *)dic
{
    _order = [[Order alloc] init];
    _order.partner = PartnerID;
    _order.seller = SellerID;
    _order.tradeNO = [NSString stringWithFormat:@"%@", [dic objectForKey:@"orderSn"]];
    _order.productName = [NSString stringWithFormat:@"您的%@件商品共计", [dic objectForKey:@"quantity"]];
    _order.productDescription = @"宝源商品";
    _order.amount = [NSString stringWithFormat:@"%@", [dic objectForKey:@"price"]];
    _order.notifyURL = @"http://www.wosun.net.cn";
    return [_order description];
}
- (NSString *)doRsa:(NSString *)orderInfo
{
    id<DataSigner>signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString * signedString = [signer signString:orderInfo];
    return signedString;
}
@end
