//
//  HYZMoneyChangeRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZMoneyChangeModel.h"

@protocol HYZMoneyChangeRequestDelegate <NSObject>

- (void)getMoneyChangeMessageSuccess:(NSArray *)messageArray;

- (void)getMoneyChangeMessageFaild:(NSString *)faildString;

@end

@interface HYZMoneyChangeRequest : NSObject

@property (nonatomic, assign) id <HYZMoneyChangeRequestDelegate> delegate;

- (void)getMoneyChangeMessage:(NSString *)urlString;

@end
