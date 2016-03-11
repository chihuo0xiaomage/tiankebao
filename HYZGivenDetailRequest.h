//
//  HYZGivenDetailRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZPrepaildPlanModel.h"

@protocol HYZGivenDetailRequestDelegate <NSObject>

- (void)getGivenDetailSuccess:(NSArray *)dataListArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZGivenDetailRequest : NSObject

@property (nonatomic, assign)id <HYZGivenDetailRequestDelegate> delegate;

- (void)getGivenDetailRequest:(NSString *)urlString;

@end
