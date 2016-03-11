//
//  HYZGetUserMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-21.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGetUserMessageRequest.h"

@implementation HYZGetUserMessageRequest

- (void)getUserMessageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZGetUerMessageModel *model = [[HYZGetUerMessageModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(getMessage:openToken:password:userName:)]) {
                [_delegate getMessage:model.message openToken:model.opentoken password:model.password userName:[model.username stringByReplacingOccurrencesOfString:@"#" withString:@"@"]];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
