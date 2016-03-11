//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088011708715400"
//收款支付宝账号
#define SellerID  @"wswlzfb@126.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJ62wpd/bXGwaA0i/6I+IG0cYvM/GhiUjpXofg8RlfFLf0SoNAFHQn318ZjbmDGPIBWDWHEM2Yhvuyv7XZCiGsBI6E6YHs8S6xN5wYNtKKSF0gd1BRIutqw3zcQJ+ztUDqhlZdAywO9pTp69c98vARh1rzxVEbA6rRsmvFaE1gcXAgMBAAECgYB7urh6yJF2pvKHAzjMr6gxx4ZwYUojzXRW83eKocgF4zhlOsfIE1iHv/tHkjHUuOJnQwzonP7c+VWuVPi9L1KwSAcIcYLRHeAGiIwJTXTMh0zTXEAhdpo1z4Dsh0RGE6jYsZ4gnLuTVKVDVXGI5IlZFLz9tv678mGPoRaoE1omoQJBAM5kuGby0nwe/8oQ1trXlDmdTFiDKFi1CBOQmZpmmrCaCG5PoD+MA03YZq4NDTSHFOhoD/OAFe5MGtzHtrayU2cCQQDE3Ffht2Prqsn7RKenU2x7wqy+0hDD4mwy6p/4Wk02ErWrR/tvFaKnoJG6PvqN8HkU5sF+X3I8zFbvYuXvOpDRAkEAnuFmGsn+QlJSsih4XQrrLdbq+JAutOrXBsiflf46QoywxMpDH+gWewyFLqMZcUAzVh0Vems1drXbT+3lt4pbLQJALKYNCJSfhQPna6XWoIy7PhaZN25NfyALikDMp3dTq7/ylDZvQHKXwY0ZgDRof2jbDXKI0DC1qDRwQzsbC3ctAQJBAJ7L8gLtkDdORNLt/9wODaFioLtL1KPsLWwCfl6apqFqENORPiDZnSXrn4fToJ3eoydoEphuvlg/aLoItvLKI1I="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
