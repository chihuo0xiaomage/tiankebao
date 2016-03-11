//
//  HYZMoneyChangeDetailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZMoneyChangeDetailModel : JSONModel

@property (nonatomic, strong) NSString  <Optional>   *DCHANGE_MONEY;

@property (nonatomic, strong) NSString  <Optional>   *DCHANGE_TYPE;

@property (nonatomic, strong) NSString  <Optional>   *DDATE;

@property (nonatomic, strong) NSString  <Optional>   *DFANO;

@property (nonatomic, strong) NSString  <Optional>   *DPAYMODE;

@property (nonatomic, strong) NSString  <Optional>   *DSHOP;

@property (nonatomic, strong) NSString  <Optional>   *DSHOPNAME;

@property (nonatomic, strong) NSString  <Optional>   *RN;

@end
