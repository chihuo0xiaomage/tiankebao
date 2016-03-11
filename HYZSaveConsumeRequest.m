//
//  HYZSaveConsumeRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSaveConsumeRequest.h"

@implementation HYZSaveConsumeRequest

- (void)commitConsumeMessageRequest:(NSString *)urlSring barCode:(NSString *)barCode
{
    [JSONHTTPClient postJSONFromURLWithString:urlSring bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZSaveConsumeModel *model = [[HYZSaveConsumeModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(requestSuccess:barCode:)]) {
                [_delegate requestSuccess:model.message barCode:barCode];
            }
        }
        else if ([model.result isEqualToString:@"false"]){
            if ([_delegate respondsToSelector:@selector(requestError:)]) {
                [_delegate requestError:model.message];
            }
        }else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"请求失败"];
            }
        }
        
    }];
}

@end
