//
//  HYZOpinion.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HYZOpinionDelegate <NSObject>

- (void)passOpinion:(NSString *)moneyString;

- (void)opinionFaild:(NSString *)faildString;

- (void)pass;

@end

@interface HYZOpinion : NSObject

@property (nonatomic, assign)id <HYZOpinionDelegate> delegate;

- (void)opinionRangeOfMoney:(NSString *)moneyString minValue:(NSString *)minString maxValur:(NSString *)maxString;

- (void)opinionPassWorld:(NSString *)pswString;

@end
