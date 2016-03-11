//
//  HYZShoppCommitRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZShoppCommitRequest.h"

@implementation HYZShoppCommitRequest

- (void)commitShopMessageRequest:(NSString *)urlString barCode:(NSString *)barCode
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZShoppCommitModel *model = [[HYZShoppCommitModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(commitSuccess:barCode:)]) {
                [_delegate commitSuccess:model.message barCode:barCode];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(commitFaild:)]) {
                [_delegate commitFaild:@"支付失败"];
            }
        }
    }];
}

@end
