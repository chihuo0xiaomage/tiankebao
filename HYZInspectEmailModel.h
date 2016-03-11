//
//  HYZInspectEmailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZInspectEmailModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *message;

@property(strong,nonatomic)NSString<Optional> *opentoken;

@property(strong,nonatomic)NSString<Optional> *password;

@property(strong,nonatomic)NSString<Optional> *username;

@property(strong,nonatomic)NSString *status;


@end
