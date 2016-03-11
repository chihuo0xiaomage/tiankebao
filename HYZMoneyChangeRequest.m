//
//  HYZMoneyChangeRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMoneyChangeRequest.h"

@implementation HYZMoneyChangeRequest

- (void)getMoneyChangeMessage:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZMoneyChangeModel *model = [[HYZMoneyChangeModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"])
        {
            if ([_delegate respondsToSelector:@selector(getMoneyChangeMessageSuccess:)]) {
                [ _delegate getMoneyChangeMessageSuccess:model.dataList];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(getMoneyChangeMessageFaild:)]) {
                [_delegate getMoneyChangeMessageFaild:@"请求失败"];
            }
        }
    }];
}

@end
