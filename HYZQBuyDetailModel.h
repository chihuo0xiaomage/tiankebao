//
//  HYZQBuyDetailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZQBuyDetailModel : JSONModel

@property (nonatomic, strong) NSString  <Optional>   *barcode;

@property (nonatomic, assign) long long              createDate;

@property (nonatomic, strong) NSString  <Optional>   *pmoney;

@end
