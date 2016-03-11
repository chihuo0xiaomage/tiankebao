//
//  HYZMessageDetailModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZMessageDetailModel : JSONModel

@property (nonatomic, strong) NSString <Optional>   *createDate;

@property (nonatomic, strong) NSString <Optional>   *isNewmsg;

@property (nonatomic, strong) NSString <Optional>   *isPingjia;

@property (nonatomic, strong) NSString <Optional>   *message;

@property (nonatomic, strong) NSString <Optional>   *messageType;

@property (nonatomic, strong) NSString <Optional>   *message_id;

@property (nonatomic, strong) NSString <Optional>   *tenantcode;

@property (nonatomic, strong) NSString <Optional>   *title;

@property (nonatomic, strong) NSString <Optional>   *uri;

@end
