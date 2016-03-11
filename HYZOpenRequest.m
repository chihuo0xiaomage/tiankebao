//
//  HYZOpenRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZOpenRequest.h"

@implementation HYZOpenRequest

- (void)openMyCardRequst:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZOpengModel *model = [[HYZOpengModel alloc] initWithDictionary:dic error:nil];
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(openMyCardSuccess:)]) {
                [_delegate openMyCardSuccess:model.message];
            }
        }
        else if ([model.result isEqualToString:@"false"]){
            if ([_delegate respondsToSelector:@selector(cardPasswordWordWrong:)]) {
                [_delegate cardPasswordWordWrong:model.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(openMyCardFaild:)]) {
                [_delegate openMyCardFaild:@"请求失败"];
            }
        }
    }];
}

@end
