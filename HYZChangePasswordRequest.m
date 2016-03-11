//
//  HYZChangePasswordRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZChangePasswordRequest.h"

@implementation HYZChangePasswordRequest

- (void)changeCardPasswordRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZChangePasswordModel *model = [[HYZChangePasswordModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"])
        {
            if ([_delegete respondsToSelector:@selector(changeCardPasswordSuccess:)])
            {
                [_delegete changeCardPasswordSuccess:model.message];
            }
        }
        else
        {
            if ([_delegete respondsToSelector:@selector(changeCardPasswordFaild:)]) {
                [_delegete changeCardPasswordFaild:@"请求失败"];
            }
        }
    }];
}

@end
