//
//  HYZPrepaidPlanRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZPrepaidPlanRequest.h"

@implementation HYZPrepaidPlanRequest

- (void)getPrepaildPlanRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyString:nil completion:^(       NSDictionary *dic, JSONModelError *error){
        HYZPrepaildPlanModel *model = [[HYZPrepaildPlanModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(getPrepaildPlanRequestSuccess:)])
            {
                [_delegate getPrepaildPlanRequestSuccess:model.dataList];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(requestFaild:)])
            {
                [_delegate requestFaild:@"请求失败"];
            }
        }
            //DFANO DFANAME
    }];
}

@end
