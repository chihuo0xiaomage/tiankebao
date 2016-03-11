//
//  HYZLinkEmailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZLinkEmailModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *message;

@property (nonatomic, strong) NSString            *status;

@end
