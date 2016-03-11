//
//  HYZCardDetailMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZCardMessageModel.h"

@protocol HYZCardDetailMessageRequestDelegate <NSObject>

- (void)getCardMessageSuccess:(NSDictionary *)messageDictionary;

- (void)getCardMessageFaild:(NSString *)faildString;

@end

@interface HYZCardDetailMessageRequest : NSObject

@property (nonatomic, assign) id <HYZCardDetailMessageRequestDelegate> delegate;

- (void)getCardMessageRequest:(NSString *)urlString;

@end
