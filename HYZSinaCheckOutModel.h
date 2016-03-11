//
//  HYZSinaCheckOutModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZSinaCheckOutModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *appkey;

@property(strong,nonatomic)NSString<Optional> *create_at;

@property(strong,nonatomic)NSString<Optional> *expire_in;

@property(strong,nonatomic)NSString<Optional> *uid;

@end
