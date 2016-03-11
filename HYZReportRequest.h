//
//  HYZReportRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZReportModel.h"

@protocol HYZReportRequestDelegate <NSObject>

- (void)reportMyCardSuccess:(NSString *)successString;

- (void)reportMyCardFaild:(NSString *)faildString;

@end

@interface HYZReportRequest : NSObject

@property (nonatomic, assign)id <HYZReportRequestDelegate> delegate;

- (void)reportMyCardRequest:(NSString *)urlString;

@end
