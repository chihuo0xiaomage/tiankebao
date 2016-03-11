//
//  HYZOpinionCardModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZOpinionCardModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *message;

@property (nonatomic, strong) NSString            *result;

@end
