//
//  HYZLoginModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZLoginModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *message;

@property(strong,nonatomic)NSString           *status;

@end