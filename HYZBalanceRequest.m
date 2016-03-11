//
//  HYZBalanceRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZBalanceRequest.h"

@implementation HYZBalanceRequest

- (void)getCardMessge:(NSString *)urlString
{

    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        if ([dic count] == 2)
        {
            HYZBalanceModel1 *model = [[HYZBalanceModel1 alloc] initWithDictionary:dic error:nil];
            
            if ([model.result isEqualToString:@"false"])
            {
                if ([_delegate respondsToSelector:@selector(wrongCard:)]) {
                    [_delegate wrongCard:model.message];
                }
            }
            else
            {
                if ([_delegate respondsToSelector:@selector(getCardMessageFaild:)]) {
                        [_delegate getCardMessageFaild:@"请求失败"];
                    }
            }
        }
        else
        {
            HYZBalanceModel *model = [[HYZBalanceModel alloc] initWithDictionary:dic error:nil];

            if ([model.result isEqualToString:@"true"]) {
                if ([_delegate respondsToSelector:@selector(getCardMessageSuccess:)]) {
                    [_delegate getCardMessageSuccess:model.cardInfo];
                }
            }
            
            else
            {
                if ([_delegate respondsToSelector:@selector(getCardMessageFaild:)]) {
                        [_delegate getCardMessageFaild:@"请求失败"];
                    }
            }
        }
    }];
     
}

@end
