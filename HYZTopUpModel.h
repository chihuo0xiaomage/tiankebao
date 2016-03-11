//
//  HYZTopUpModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZTopUpModel : JSONModel

@property (nonatomic, strong) NSString <Optional>    *maxValue;

@property (nonatomic, strong) NSString <Optional>    *message;

@property (nonatomic, strong) NSString <Optional>    *minValue;

@property (nonatomic, strong) NSString               *result;

@end
