//
//  BYAlipay.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"
@interface BYAlipay : NSObject
@property(nonatomic, strong)NSDictionary * shopDic;
- (void)startPayMoney:(NSDictionary *)dic;
@property(nonatomic,strong)Order *order;

@end
