//
//  HYZPrepaidPlanRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZPrepaildPlanModel.h"

@protocol HYZPrepaidPlanRequestDelegate <NSObject>

- (void)getPrepaildPlanRequestSuccess:(NSArray *)dataListArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZPrepaidPlanRequest : NSObject

@property (nonatomic, assign) id <HYZPrepaidPlanRequestDelegate>  delegate;

- (void)getPrepaildPlanRequest:(NSString *)urlString;

@end
