//
//  HYZLinkEmailPasswordModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZLinkEmailPasswordModel : JSONModel

@property (nonatomic, strong) NSString <Optional>      *status;

@property (nonatomic, strong) NSString                 *message;

@end
