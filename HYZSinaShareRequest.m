//
//  HYZSinaShareRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSinaShareRequest.h"

@implementation HYZSinaShareRequest

- (void)shareMessageToSina:(NSString *)urlString bodaString:(NSString *)bodyString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:bodyString completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZSinaShareModel *model = [[HYZSinaShareModel alloc] initWithDictionary:dic error:nil];
        if (model.id) {
            if ([_delegate respondsToSelector:@selector(shareSuccess:)]) {
                [_delegate shareSuccess:@"分享成功"];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"分享失败"];
            }
        }
    }];
}

@end
