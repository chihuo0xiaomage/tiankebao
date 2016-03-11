//
//  HYZQ-BuyHistoryRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZQ-BuyHistoryRequest.h"

#import "SBJsonParser.h"

@implementation HYZQ_BuyHistoryRequest

- (void)getUserShoppingMessageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){        
        HYZQ_BuyHistoryModel *model = [[HYZQ_BuyHistoryModel alloc] initWithDictionary:dic error:nil];
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(historyRequestSuccess:)]) {
                [_delegate historyRequestSuccess:[jsonParser objectWithString:model.message]];
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
