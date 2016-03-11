//
//  HYZRelieveRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZRelieveRequest.h"

@implementation HYZRelieveRequest

- (void)relieveTheCardRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZRelieveModel *model = [[HYZRelieveModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(relieveRequestSuccess:)]) {
                [_delegate relieveRequestSuccess:model.message];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(relieveRequestSuccess:)]) {
                [_delegate relieveRequestFaild:@"请求失败"];
            }
        }
    }];
}

@end
