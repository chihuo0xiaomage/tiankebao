//
//  HYZCardDetailMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCardDetailMessageRequest.h"

@implementation HYZCardDetailMessageRequest

- (void)getCardMessageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        HYZCardMessageModel *model = [[HYZCardMessageModel alloc] initWithDictionary:dic error:nil];
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(getCardMessageSuccess:)]) {
                [_delegate getCardMessageSuccess:model.cardDetail];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(getCardMessageFaild:)]) {
                [_delegate getCardMessageFaild:@"请求失败"];
            }
        }
    }];
}

@end
