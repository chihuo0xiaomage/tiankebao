//
//  HYZGivenTypeRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZPrepaildPlanModel.h"

@protocol HYZGivenTypeRequestDelegate <NSObject>

- (void)getGivenTypeSuccess:(NSArray *)dataListArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZGivenTypeRequest : NSObject

@property (nonatomic, assign) id <HYZGivenTypeRequestDelegate>  delegate;

- (void)getGivenTypeRequest:(NSString *)urlString;

@end
