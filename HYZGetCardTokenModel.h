//
//  HYZGetCardTokenModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZGetCardTokenModel : JSONModel

@property (nonatomic, strong) NSString   <Optional>   *message;

@property (nonatomic, strong) NSString   <Optional>   *token;

@property (nonatomic, strong) NSString                *result;

@end