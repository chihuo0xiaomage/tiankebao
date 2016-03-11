//
//  HYZGoodMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGoodMessageRequest.h"

@implementation HYZGoodMessageRequest

- (void)requestGoodMessage:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *errof){
        HYZGoodMessageModel *model = [[HYZGoodMessageModel alloc] initWithDictionary:dic error:nil];
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];

        if ([model.status isEqualToString:@"success"] && [[jsonParser objectWithString:model.message] count]>0) {
            if ([_delegate respondsToSelector:@selector(getGoodMessageSuccess:)]) {
                [_delegate getGoodMessageSuccess:[jsonParser objectWithString:model.message]];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
