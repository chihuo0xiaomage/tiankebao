//
//  HYZBalanceRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZBalanceModel.h"

#import "HYZBalanceModel1.h"

@protocol HYZBalanceRequestDelegate <NSObject>

- (void)getCardMessageSuccess:(NSDictionary *)messageDic;

- (void)getCardMessageFaild:(NSString *)faildString;

- (void)wrongCard:(NSString *)faildString;

@end

@interface HYZBalanceRequest : NSObject

@property (nonatomic, assign) id <HYZBalanceRequestDelegate> delegate;

- (void)getCardMessge:(NSString *)urlString;

@end
