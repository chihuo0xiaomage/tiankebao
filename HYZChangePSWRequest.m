//
//  HYZChangePSWRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZChangePSWRequest.h"

@implementation HYZChangePSWRequest

- (void)changePasswordRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZChangePSWModel *model = [[HYZChangePSWModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(changePasswordSuccess:)]) {
                [_delegate changePasswordSuccess:model.message];
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
