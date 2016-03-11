//
//  HYZPromotionRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "SBJson.h"

@protocol HYZPromotionRequestDelegate <NSObject>

- (void)getmessageSuccess:(NSArray *)messageArray;

- (void)getmessageFaild:(NSString *)faildString;

@end

@interface HYZPromotionRequest : NSObject

@property (nonatomic, assign)id <HYZPromotionRequestDelegate> delegate;

- (id)initWithUrlString:(NSString *)urlString;

@end
