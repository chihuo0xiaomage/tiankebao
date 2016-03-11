//
//  Products.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "Products.h"

@implementation Products
- (id)initWithMoreProductsNSDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.image = [dic objectForKey:@"image"];
        self.name = [dic objectForKey:@"name"];
        self.marketPrice = [dic objectForKey:@"marketPrice"];
        self.price = [dic objectForKey:@"price"];
        self.gid = [dic objectForKey:@"gid"];
        self.scoreCount = [[dic objectForKey:@"scoreCount"] integerValue];
        self.score = [[dic objectForKey:@"score"] integerValue];
        self.imageUrl = [dic objectForKey:@"image"];
    }
    return self;
}

@end
