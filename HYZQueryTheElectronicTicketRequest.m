//
//  HYZQueryTheElectronicTicketRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZQueryTheElectronicTicketRequest.h"

@implementation HYZQueryTheElectronicTicketRequest

- (void)getElectronicMessageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZQueryTheElectronicTicketModel *model = [[HYZQueryTheElectronicTicketModel alloc] initWithDictionary:dic error:nil];
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(getMessageSuccess:)]) {
                [_delegate getMessageSuccess:model.dataList];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(getMessageFaild:)]) {
                [_delegate getMessageFaild:@"请求失败"];
            }
        }
    }];
}

@end
