//
//  HYZCardBagModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZCardBagModel : JSONModel

@property (nonatomic, strong) NSArray                *message;

@property (nonatomic, strong) NSString  <Optional>   *status;

@end
