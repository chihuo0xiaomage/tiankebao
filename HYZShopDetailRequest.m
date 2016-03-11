//
//  HYZShopDetailRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZShopDetailRequest.h"

@implementation HYZShopDetailRequest

- (void)shopDetailSentRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZShopDetailModel *model = [[HYZShopDetailModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(shopDetailSentSuccess:)]) {
                [_delegate shopDetailSentSuccess:model.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
