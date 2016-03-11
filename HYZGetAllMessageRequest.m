//
//  HYZGetAllMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGetAllMessageRequest.h"

#import "SBJsonParser.h"

@implementation HYZGetAllMessageRequest

- (void)getAllMessageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic ,JSONModelError *error){
        
        HYZGetAllMessageModel *messageModel = [[HYZGetAllMessageModel alloc] initWithDictionary:dic error:nil];
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        
        if ([messageModel.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(getUserMessageSuccess:)]) {
                [_delegate getUserMessageSuccess:[jsonParser objectWithString:messageModel.message]];
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
