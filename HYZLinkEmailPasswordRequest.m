//
//  HYZLinkEmailPasswordRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZLinkEmailPasswordRequest.h"

@implementation HYZLinkEmailPasswordRequest

- (void)sentEmailPasswordRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZLinkEmailPasswordModel *model = [[HYZLinkEmailPasswordModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(linkSuccess:)]) {
                [_delegate linkSuccess:model.message];
            }
        }
        else if ([model.status isEqualToString:@"warn"] || [model.status isEqualToString:@"error"])
        {
            if ([_delegate respondsToSelector:@selector(linkError:)]) {
                [_delegate linkError:@"密码错误,绑定失败"];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
