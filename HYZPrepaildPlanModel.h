//
//  HYZPrepaildPlanModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZPrepaildPlanModel : JSONModel

@property (nonatomic, strong) NSArray            *dataList;

@property (nonatomic, strong) NSString <Optional> *message;

@property (nonatomic, strong) NSString            *result;

@end
