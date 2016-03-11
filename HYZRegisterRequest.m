

    //
//  HYZRegisterRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZRegisterRequest.h"

@implementation HYZRegisterRequest

- (void)registerRequest:(NSString *)urlSting
{
    [JSONHTTPClient postJSONFromURLWithString:urlSting bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZRegisterModel *model = [[HYZRegisterModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(registerSuccessString:)]) {
                [_delegate registerSuccessString:model.message];
            }
        }
        else if ([model.status isEqualToString:@"warn"]){
            if ([_delegate respondsToSelector:@selector(registerSuccessString:)]) {
                [_delegate registerSuccessString:model.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(requestFaildString:)]) {
                [_delegate requestFaildString:@"请求失败"];
            }
        }
    }];
}

@end
