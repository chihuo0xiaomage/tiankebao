//
//  BYCatelogs.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYCatelogs : NSObject

@property(nonatomic, strong)NSString * catelogId;
@property(nonatomic, strong)NSString * icon;
@property(nonatomic, strong)NSString * name;
@property(nonatomic, strong)NSString * cid;
- (id)initWithCatelogDictionary:(NSDictionary *)catelogsDic;
@end
