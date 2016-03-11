//
//  HYZTopUpRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZTopUpModel.h"

@protocol HYZTopUpRequestDelegate <NSObject>

- (void)getTopUpMessageSuccess:(NSString *)maxValueString message:(NSString *)messageString minValue:(NSString *)minValueString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZTopUpRequest : NSObject

@property (nonatomic, assign) id <HYZTopUpRequestDelegate>   delegate;

- (void)getTheScopeOfMoneyRequest:(NSString *)urlString;

@end
