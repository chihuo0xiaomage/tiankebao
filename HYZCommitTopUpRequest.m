//
//  HYZCommitTopUpRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCommitTopUpRequest.h"

@implementation HYZCommitTopUpRequest

- (void)commitChongZhiMessageRequest:(NSString *)urlString{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:nil completion:^(NSDictionary *dic, JSONModelError *error){
        HYZCommitTopUpModel *model = [[HYZCommitTopUpModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"false"])
        {
            if ([_delegate respondsToSelector:@selector(commitTopUpMessagefalse:)]) {
                [_delegate commitTopUpMessagefalse:model.message];
            }
        }
        else if ([model.result isEqualToString:@"true"])
        {
            if ([_delegate respondsToSelector:@selector(commitTopUpMessageSuccess:)]) {
                [_delegate commitTopUpMessageSuccess:@"交易成功"];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
