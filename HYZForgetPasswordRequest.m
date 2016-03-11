//
//  HYZForgetPasswordRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZForgetPasswordRequest.h"

@implementation HYZForgetPasswordRequest

- (void)forgotUserPasswordRequest:(NSString *)urlString{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZRegisterModel *model = [[HYZRegisterModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(requestSuccess:)]) {
                [_delegate requestSuccess:model.message];
            }
        }
        else if ([model.status isEqualToString:@"warn"]){
            if ([_delegate respondsToSelector:@selector(requestSuccess:)]) {
                [_delegate requestSuccess:model.message];
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
