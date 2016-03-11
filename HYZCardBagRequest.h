//
//  HYZCardBagRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZCardBagModel.h"

@protocol HYZCardBagRequestDelegate <NSObject>

- (void)getInfoSuccess:(NSArray *)messageArray;

- (void)getInfoFaild:(NSString *)faildString;

@end

@interface HYZCardBagRequest : NSObject

@property (nonatomic, assign) id <HYZCardBagRequestDelegate> delegate;

- (void)getUserAllCardRequest:(NSString *)urlString;

@end
