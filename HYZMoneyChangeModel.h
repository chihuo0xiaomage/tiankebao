//
//  HYZMoneyChangeModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZMoneyChangeModel : JSONModel

@property (nonatomic, strong) NSArray              *dataList;

@property (nonatomic, strong) NSString  <Optional> *message;

@property (nonatomic, strong) NSString  <Optional> *pageCount;

@property (nonatomic, strong) NSString  <Optional> *pageNumber;

@property (nonatomic, strong) NSString  <Optional> *pageSize;

@property (nonatomic, strong) NSString             *result;

@property (nonatomic, strong) NSString  <Optional> *totalCount;

@end
