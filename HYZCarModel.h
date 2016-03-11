//
//  HYZCarModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZCarModel : JSONModel

@property (nonatomic, strong) NSString <Optional>     *DBARCODE;

@property (nonatomic, strong) NSString <Optional>     *DNAME;

@property (nonatomic, strong) NSString <Optional>     *DPRICE;

@end
