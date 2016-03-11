//
//  HYZQ-BuyHistoryRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZQ-BuyHistoryModel.h"

@protocol HYZQ_BuyHistoryRequestDelegate <NSObject>

- (void)historyRequestSuccess:(NSArray *)messageArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZQ_BuyHistoryRequest : NSObject

@property (nonatomic, assign) id <HYZQ_BuyHistoryRequestDelegate>  delegate;

- (void)getUserShoppingMessageRequest:(NSString *)urlString;

@end
