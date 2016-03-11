//
//  HYZHistoryRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZHistoryModel.h"

@protocol HYZHistoryRequestDelegate <NSObject>

- (void)getHistorySuccess:(NSArray *)messageArray;

- (void)getHistoryFaild:(NSString *)faildString;

@end

@interface HYZHistoryRequest : NSObject

@property (nonatomic, assign) id <HYZHistoryRequestDelegate> delegate;

- (void)getCardHistroyMessage:(NSString *)urlString;

@end
