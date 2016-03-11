//
//  HYZQueryTheElectronicTicketDataListModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZQueryTheElectronicTicketDataListModel : JSONModel

@property (nonatomic, strong) NSString  <Optional>   *DNO;

@property (nonatomic, strong) NSString  <Optional>   *DDATE;

@property (nonatomic, strong) NSString  <Optional>   *DDZQNAME;

@property (nonatomic, strong) NSString  <Optional>   *DTYPE;

@property (nonatomic, strong) NSString  <Optional>   *DSUBSHOP;

@property (nonatomic, strong) NSString  <Optional>   *DSHOPNAME;

@property (nonatomic, strong) NSString  <Optional>   *DATTACHNO;

@property (nonatomic, strong) NSString  <Optional>   *DCARD_MONEY;

@property (nonatomic, strong) NSString  <Optional>   *DPOSNO;

@end
