//
//  HYZOpinionCardRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZOpinionCardRequest.h"

@implementation HYZOpinionCardRequest

- (void)opinionCardRequest:(NSString *)urlString{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:nil completion:^(NSDictionary *dic, JSONModelError *error){
        HYZOpinionCardModel *model = [[HYZOpinionCardModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(opinionSuccess:)]) {
                [_delegate opinionSuccess:model.message];
            }
        }else if ([model.result isEqualToString:@"false"]){
            if ([_delegate respondsToSelector:@selector(opinionFalse:)]) {
                [_delegate opinionFalse:model.message];
            }
        }else {
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
