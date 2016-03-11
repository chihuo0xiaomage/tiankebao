//
//  HYZDMMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZDMMessageModel.h"

@protocol HYZDMMessageRequestDelegate <NSObject>

- (void)getDMMessageSuccess:(NSArray *)messageArray mainmsgDictionary:(NSDictionary*)dictionary;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZDMMessageRequest : NSObject

@property (nonatomic, assign) id <HYZDMMessageRequestDelegate>     delegate;

- (void)DMMessageRequest:(NSString *)urlString;

@end
