//
//  HYZGetCardRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGetCardRequest.h"

@implementation HYZGetCardRequest

- (void)getCardRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:nil completion:^(NSDictionary *dic, JSONModelError *error){
        HYZGetCardModel *model = [[HYZGetCardModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(getUserCardSuccess:)]) {
                [_delegate getUserCardSuccess:model.message];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"获取用户卡失败"];
            }
        }
    }];
}

@end
