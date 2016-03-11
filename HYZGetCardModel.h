//
//  HYZGetCardModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZGetCardModel : JSONModel

@property (nonatomic, strong) NSArray     *message;

@property (nonatomic, strong) NSString    *status;

@end
