//
//  HYZInspectRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

@protocol HYZInspectRequestDelegate <NSObject>

- (void)getVersionSuccess:(NSString *)nowVersion;

- (void)getVersionFaild:(NSString *)faileString;

@end

@interface HYZInspectRequest : NSObject

@property (nonatomic, assign) id <HYZInspectRequestDelegate> delegate;

- (void)updata:(NSString *)urlString;

@end
