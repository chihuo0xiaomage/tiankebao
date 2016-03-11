//
//  HYZDetailBalanceModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZDetailBalanceModel : JSONModel

@property (nonatomic, strong) NSString <Optional>  *cardNo;

@property (nonatomic, strong) NSString <Optional>  *totalMoney;

@property (nonatomic, strong) NSString <Optional>  *consumeMoney;

@property (nonatomic, strong) NSString <Optional>  *consumeJifen;

@end
