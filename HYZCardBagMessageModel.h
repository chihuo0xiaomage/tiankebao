//
//  HYZCardBagMessageModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZCardBagMessageModel : JSONModel

@property (nonatomic, strong) NSString  <Optional>   *cardNo;

@property (nonatomic, strong) NSString  <Optional>   *cardPwd;

@property (nonatomic, strong) NSString  <Optional>   *isdefault;

@end
