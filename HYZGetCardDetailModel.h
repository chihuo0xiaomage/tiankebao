//
//  HYZGetCardDetailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZGetCardDetailModel : JSONModel

@property (nonatomic, strong) NSString <Optional> *cardNo;

@property (nonatomic, strong) NSString <Optional> *cardPwd;

@property (nonatomic, strong) NSString <Optional> *isdefault;

@end
