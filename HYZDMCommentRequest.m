//
//  HYZDMCommentRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZDMCommentRequest.h"

@implementation HYZDMCommentRequest

- (void)commentUserMessageRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        HYZCommentMessageModel *commentModel = [[HYZCommentMessageModel alloc] initWithDictionary:dic error:nil];
        if ([commentModel.status isEqualToString:@"success"] || [commentModel.status isEqualToString:@"warn"]) {
            if ([_delegate respondsToSelector:@selector(commentSuccess:)]) {
                [_delegate commentSuccess:commentModel.message];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
    }];
}

- (void)serveCommentRequest:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        HYZCommentMessageModel *commentModel = [[HYZCommentMessageModel alloc] initWithDictionary:dic error:nil];
        if ([commentModel.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(serveCommentSuccess:)]) {
                [_delegate serveCommentSuccess:commentModel.message];
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
