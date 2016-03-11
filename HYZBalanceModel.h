//
//  HYZBalanceModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZBalanceModel : JSONModel

@property (nonatomic, strong) NSDictionary         *cardInfo;

@property (nonatomic, strong) NSString <Optional>  *message;

@property (nonatomic, strong) NSString             *result;

@end
