//
//  HYZUserMessageDetailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZUserMessageDetailModel : JSONModel

@property (nonatomic, strong) NSString <Optional>   *groupName;

@property (nonatomic, strong) NSString <Optional>   *id;

@property (nonatomic, strong) NSString <Optional>   *shop_head;

@property (nonatomic, strong) NSString <Optional>   *tenantCode;

@end
