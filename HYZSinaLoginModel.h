//
//  HYZSinaLoginModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZSinaLoginModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *access_token;

@property(strong,nonatomic)NSString<Optional> *expires_in;

@property(strong,nonatomic)NSString<Optional> *remind_in;

@property(strong,nonatomic)NSString<Optional> *uid;

@end
