//
//  HYZChangePasswordRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZChangePasswordModel.h"

@protocol HYZChangePasswordRequestDelegate <NSObject>

- (void)changeCardPasswordSuccess:(NSString *)successString;

- (void)changeCardPasswordFaild:(NSString *)faildString;

@end

@interface HYZChangePasswordRequest : NSObject

@property (nonatomic, assign) id <HYZChangePasswordRequestDelegate> delegete;

- (void)changeCardPasswordRequest:(NSString *)urlString;

@end
