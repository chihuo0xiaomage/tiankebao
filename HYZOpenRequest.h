//
//  HYZOpenRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZOpengModel.h"

@protocol HYZOpenRequestDelegate <NSObject>

- (void)openMyCardSuccess:(NSString *)successString;

- (void)cardPasswordWordWrong:(NSString *)wrongString;

- (void)openMyCardFaild:(NSString *)faildString;

@end

@interface HYZOpenRequest : NSObject

@property (nonatomic, assign) id <HYZOpenRequestDelegate> delegate;

- (void)openMyCardRequst:(NSString *)urlString;

@end
