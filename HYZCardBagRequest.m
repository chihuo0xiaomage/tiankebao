//
//  HYZCardBagRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCardBagRequest.h"

@implementation HYZCardBagRequest

- (void)getUserAllCardRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZCardBagModel *model = [[HYZCardBagModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"])
        {
            if ([_delegate respondsToSelector:@selector(getInfoSuccess:)]) {
                [_delegate getInfoSuccess:model.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(getInfoFaild:)]) {
                [_delegate getInfoFaild:@"请求失败"];
            }
        }
        
    }];
}

@end
