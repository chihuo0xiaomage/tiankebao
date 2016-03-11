//
//  HYZLoginRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZLoginRequest.h"

@implementation HYZLoginRequest

- (void)loginRequest:(NSString *)urlString userName:(NSString *)nameString passwordString:(NSString *)pWSSTring access_token:(NSString *)access_token
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary * dic, JSONModelError *error ){
        
        HYZLoginModel *model = [[HYZLoginModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(loginSuccess:userName:passwordString:access_token:)]) {
                [_delegate loginSuccess:model.message userName:nameString passwordString:pWSSTring access_token:access_token];
            };
        }
        else{
            if ([_delegate respondsToSelector:@selector(loginFaild:)]) {
                [_delegate loginFaild:@"登录失败"];
            };
        }
        
    }];
}

@end
