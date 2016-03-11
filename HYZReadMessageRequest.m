//
//  HYZReadMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZReadMessageRequest.h"

@implementation HYZReadMessageRequest

- (void)readMessageRequest:(NSString *)urlString codeString:(NSString *)code
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZReadMessageModel *model = [[HYZReadMessageModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(readMessageSuccess:codeString:)]) {
                [_delegate readMessageSuccess:model.message codeString:code];
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
