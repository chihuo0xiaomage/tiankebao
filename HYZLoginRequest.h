//
//  HYZLoginRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "SBJson.h"

#import "HYZLoginModel.h"

@protocol HYZLoginRequestDelegate <NSObject>

- (void)loginSuccess:(NSString *)successString userName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token;

- (void)loginFaild:(NSString *)FaildString;

@end

@interface HYZLoginRequest : NSObject

@property (nonatomic, assign) id <HYZLoginRequestDelegate> delegate;

- (void)loginRequest:(NSString *)urlString userName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token;

@end
