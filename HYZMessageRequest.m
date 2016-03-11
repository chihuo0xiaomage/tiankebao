//
//  HYZMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMessageRequest.h"

#import "SBJsonParser.h"

@implementation HYZMessageRequest

- (void)messageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZNewMessageModel *messageModel = [[HYZNewMessageModel alloc] initWithDictionary:dic error:nil];
        if ([messageModel.status isEqualToString:@"success"]) {
            
            SBJsonParser *parse = [[SBJsonParser alloc] init];
            
            if ([_delegate respondsToSelector:@selector(getMessageSuccess:)]) {
                
                [_delegate getMessageSuccess:[parse objectWithString:messageModel.message]];
            }
            else{
                if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                    [_delegate requestFaild:@"请求失败"];
                }
            }
        }
    }];
}

- (void)UserCardMessageRequest:(NSString *)urlStr userName:(NSString *)aString
{
    [JSONHTTPClient postJSONFromURLWithString:urlStr bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZUserMessgeModel *model = [[HYZUserMessgeModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            SBJsonParser *parse = [[SBJsonParser alloc] init];
            
            if ([_delegate respondsToSelector:@selector(getUserCardMessageSuccess:userName:)]) {
                [_delegate getUserCardMessageSuccess:[parse objectWithString:model.message] userName:aString];
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
