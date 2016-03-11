//
//  HYZDMMessageModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZDMMessageModel : JSONModel

@property (nonatomic, strong) NSString <Optional>    *bmsg;

@property (nonatomic, strong) NSString <Optional>    *mainmsg;

@property (nonatomic, strong) NSString               *status;

@end
