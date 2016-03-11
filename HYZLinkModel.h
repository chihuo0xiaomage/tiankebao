//
//  HYZLinkModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZLinkModel : JSONModel

@property (nonatomic, strong) NSString <Optional>   *message;

@property (nonatomic, strong) NSString <Optional>   *nameCardMsg;

@property (nonatomic, strong) NSString <Optional>   *nameCardStatus;

@property (nonatomic, strong) NSString              *result;

@end
