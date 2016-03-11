//
//  HYZTopUpRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZTopUpRequest.h"

@implementation HYZTopUpRequest

- (void)getTheScopeOfMoneyRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZTopUpModel *topUpModel = [[HYZTopUpModel alloc] initWithDictionary:dic error:nil];
        if ([topUpModel.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(getTopUpMessageSuccess:message:minValue:)]) {
                [_delegate getTopUpMessageSuccess:[dic objectForKey:@"maxValue"] message:[dic objectForKey:@"message"] minValue:[dic objectForKey:@"minValue"]];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
