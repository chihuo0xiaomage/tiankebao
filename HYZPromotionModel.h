//
//  HYZPromotionModel.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"

@interface HYZPromotionModel : JSONModel

@property(strong,nonatomic)NSString<Optional> *id;

@property(strong,nonatomic)NSString<Optional> *huodong_head;

@property(strong,nonatomic)NSString<Optional> *huodong_jianjie;

@property(strong,nonatomic)NSString<Optional> *huodong_title;

@property(assign,nonatomic)long                createDate;

@end
