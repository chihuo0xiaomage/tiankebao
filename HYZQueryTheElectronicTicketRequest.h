//
//  HYZQueryTheElectronicTicketRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZQueryTheElectronicTicketModel.h"

@protocol HYZQueryTheElectronicTicketRequestDelegate <NSObject>

- (void)getMessageSuccess:(NSArray *)messageArray;

- (void)getMessageFaild:(NSString *)faildString;

@end

@interface HYZQueryTheElectronicTicketRequest : NSObject

@property (nonatomic, assign) id <HYZQueryTheElectronicTicketRequestDelegate> delegate;

- (void)getElectronicMessageRequest:(NSString *)urlString;

@end
