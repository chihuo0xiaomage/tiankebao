//
//  HYZGivenTypeRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGivenTypeRequest.h"

@implementation HYZGivenTypeRequest

- (void)getGivenTypeRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZPrepaildPlanModel *model = [[HYZPrepaildPlanModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(getGivenTypeSuccess:)])
            {
                [_delegate getGivenTypeSuccess:model.dataList];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(requestFaild:)])
            {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
