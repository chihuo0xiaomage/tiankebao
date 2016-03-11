//
//  HYZPromotionDetainMessageRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HYZPromotionDetainMessageRequestDelegate <NSObject>

- (void)getMessageSuccess:(NSArray *)messageArray;

- (void)getMessageFaild:(NSString *)FaildString;

@end

@interface HYZPromotionDetainMessageRequest : NSObject

@property (nonatomic, assign)id <HYZPromotionDetainMessageRequestDelegate>delegate;

- (id)initWithUrlString:(NSString *)urlString;

@end
