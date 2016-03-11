//
//  HYZReportRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-4.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZReportRequest.h"

@implementation HYZReportRequest

- (void)reportMyCardRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZReportModel *model = [[HYZReportModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"])
        {
            if ([_delegate respondsToSelector:@selector(reportMyCardSuccess:)]){
                [_delegate reportMyCardSuccess:model.message];
            }
        }
        else if ([model.result isEqualToString:@"false"])
        {
            if ([_delegate respondsToSelector:@selector(reportMyCardFaild:)]) {
                [_delegate reportMyCardFaild:model.message];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(reportMyCardFaild:)]) {
                [_delegate reportMyCardFaild:@"请求失败"];
            }
        }
    }];
}

@end
