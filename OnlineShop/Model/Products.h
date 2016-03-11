//
//  Products.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Products : NSObject
@property (nonatomic, strong)NSString * image;
@property (nonatomic, strong)NSString * name;
@property (nonatomic, strong)NSString * marketPrice;
@property (nonatomic, strong)NSString * price;
@property (nonatomic, strong)NSString * gid;
@property (nonatomic, assign)int        scoreCount;
@property (nonatomic, assign)float      score;
@property (nonatomic, strong)NSString * imageUrl;
- (id)initWithMoreProductsNSDictionary:(NSDictionary *)dic;
@end
