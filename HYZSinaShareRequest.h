//
//  HYZSinaShareRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZSinaShareModel.h"

@protocol HYZSinaShareRequestDelegarte <NSObject>

- (void)shareSuccess:(NSString *)successString;

- (void)requestFaild:(NSString *)FaildString;

@end

@interface HYZSinaShareRequest : NSObject

@property (nonatomic, assign) id <HYZSinaShareRequestDelegarte>delegate;

- (void)shareMessageToSina:(NSString *)urlString bodaString:(NSString *)bodyString;

@end
