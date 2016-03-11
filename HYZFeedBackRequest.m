//
//  HYZFeedBackRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZFeedBackRequest.h"

@implementation HYZFeedBackRequest

- (void)sendFeedBackMessage:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        HYZFeedBackModel *model = [[HYZFeedBackModel alloc] initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"])
        {
            if ([_delegate respondsToSelector:@selector(sendSuccess:)]) {
                [_delegate sendSuccess:model.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(sendFaild:)]) {
                [_delegate sendFaild:@"反馈失败"];
            }
        }
    }];
}

@end
