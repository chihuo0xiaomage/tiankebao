//
//  HYZOpinion.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZOpinion.h"

@implementation HYZOpinion

- (void)opinionRangeOfMoney:(NSString *)moneyString minValue:(NSString *)minString maxValur:(NSString *)maxString{
    if (moneyString == nil || [moneyString isEqualToString:@""]) {
        if ([_delegate respondsToSelector:@selector(opinionFaild:)]) {
            [_delegate opinionFaild:@"金额不能为空"];
        }
    }else if ([moneyString intValue] >= [minString intValue] && [moneyString intValue] <= [maxString intValue]){
        if ([_delegate respondsToSelector:@selector(passOpinion:)]) {
            [_delegate passOpinion:moneyString];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(opinionFaild:)]) {
            [_delegate opinionFaild:@"金额不在范围内"];
        }
    }
}

- (void)opinionPassWorld:(NSString *)pswString{
    if (pswString == nil || [pswString isEqualToString:@""]) {
        if ([_delegate respondsToSelector:@selector(opinionFaild:)]) {
            [_delegate opinionFaild:@"密码错误，密码为六位数字"];
        }
    }else {
        if ([_delegate respondsToSelector:@selector(pass)]) {
            [_delegate pass];
        }
    }
}

@end
