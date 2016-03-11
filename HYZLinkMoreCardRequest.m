//
//  HYZLinkMoreCardRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZLinkMoreCardRequest.h"

@implementation HYZLinkMoreCardRequest

- (void)opitionThisVaildCard:(NSString *)cardNumber password:(NSString *)passwordString token:(NSString *)tokenString
{
    NSString *urlString = [NSString stringWithFormat:@"%@/card/open/api/validCard2.do?cardNo=%@&cardPwd=%@&token=%@",URL_HTTP,cardNumber,passwordString,tokenString];
    
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic ,JSONModelError *error){
        
        HYZLinkModel *linkModel = [[HYZLinkModel alloc] initWithDictionary:dic error:nil];
        
        if ([linkModel.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(checkoutRequestSuccess:password:)]) {
                [_delegate checkoutRequestSuccess:cardNumber password:passwordString];
            }
        }
        else if ([linkModel.result isEqualToString:@"false"]){
            if ([_delegate respondsToSelector:@selector(checkoutRequestFaild:)]) {
                [_delegate checkoutRequestFaild:linkModel.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

- (void)linkCardRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *json , JSONModelError *error){
        
        HYZLinkMoreCardModel *model = [[HYZLinkMoreCardModel alloc] initWithDictionary:json error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(linkSuccess:)]) {
                [_delegate linkSuccess:model.message];
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
