//
//  HYZFeedBackModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZFeedBackModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *message;

@property(strong,nonatomic)NSString           *status;

@end
