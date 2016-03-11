//
//  BYCatelogs.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYCatelogs.h"

@implementation BYCatelogs
- (id)initWithCatelogDictionary:(NSDictionary *)catelogsDic
{
    self = [super init];
    if (self) {
        self.catelogId = [catelogsDic objectForKey:@"cid"];
        self.icon = [catelogsDic objectForKey:@"icon"];
        self.name = [catelogsDic objectForKey:@"name"];
        self.cid = [catelogsDic objectForKey:@"cid"];
    }
    return self;
}
@end
