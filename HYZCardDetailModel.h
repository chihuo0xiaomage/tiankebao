//
//  HYZCardDetailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZCardDetailModel : JSONModel

@property (nonatomic, strong) NSString  <Optional>     *address;

@property (nonatomic, strong) NSString  <Optional>     *cardLevel;

@property (nonatomic, strong) NSString  <Optional>     *cardNo;

@property (nonatomic, strong) NSString  <Optional>     *cardStatus;

@property (nonatomic, strong) NSString  <Optional>     *cardType;

@property (nonatomic, strong) NSString  <Optional>     *createDate;

//@property (nonatomic, strong) NSString  <Optional>     *initMoney;

@property (nonatomic, strong) NSString  <Optional>     *name;

@property (nonatomic, strong) NSString  <Optional>     *nation;

@property (nonatomic, strong) NSString  <Optional>     *phone;

@property (nonatomic, strong) NSString  <Optional>     *sex;

@property (nonatomic, strong) NSString  <Optional>     *shopName;

@end
