//
//  HYZHistoryRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZHistoryRequest.h"

@implementation HYZHistoryRequest

- (void)getCardHistroyMessage:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error)
    {
        HYZHistoryModel *model = [[HYZHistoryModel alloc] initWithDictionary:dic error:nil];
        if ([model.result isEqualToString:@"true"])
        {
            if ([_delegate respondsToSelector:@selector(getHistorySuccess:)]) {
                [_delegate getHistorySuccess:model.dataList];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(getHistoryFaild:)]) {
                [_delegate getHistoryFaild:@"请求失败"];
            }
        }
    }];
}

@end
