//
//  HYZDetailMSGRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZDetailMSGModel.h"

@protocol HYZDetailMSGRequestDelegate <NSObject>

- (void)getShoppingDetailMessageSuccess:(NSArray *)messsageArray;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZDetailMSGRequest : NSObject

@property (nonatomic, assign) id <HYZDetailMSGRequestDelegate>  delegare;

- (void)getShoppingDetailMessageRequset:(NSString *)urlString;

@end
