//
//  HYZGetUerMessageModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZGetUerMessageModel : JSONModel

@property (nonatomic, strong) NSString <Optional>   *message;

@property (nonatomic, strong) NSString <Optional>   *opentoken;

@property (nonatomic, strong) NSString <Optional>   *password;

@property (nonatomic, strong) NSString <Optional>   *username;

@property (nonatomic, strong) NSString              *status;

@end
