//
//  HYZLinkEmailRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZLinkEmailRequest.h"

@implementation HYZLinkEmailRequest

- (void)AddEmailLinkRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZLinkEmailModel *model = [[HYZLinkEmailModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(linkEmailSuccess:)]) {
                [_delegate linkEmailSuccess:model.message];
            }
        }
        else if ([model.status isEqualToString:@"error"]){
            if ([_delegate respondsToSelector:@selector(linkEmailError:)]) {
                [_delegate linkEmailError:model.message];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
