//
//  HYZDetailmessageModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZDetailmessageModel : JSONModel

@property(strong, nonatomic) NSString<Optional> *huodong_head;

@property(strong, nonatomic) NSString<Optional> *huodong_jianjie;

@property(strong, nonatomic) NSString<Optional> *huodong_node;

@property(strong, nonatomic) NSString<Optional> *huodong_title;

@property(strong, nonatomic) NSString<Optional> *sellerid;

@property(strong, nonatomic) NSString<Optional> *sellername;

@property(strong, nonatomic) NSString<Optional> *selleruuid;

@property(assign, nonatomic) long                createDate;

@end
