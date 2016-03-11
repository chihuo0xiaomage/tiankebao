//
//  HYZDMMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZDMMessageRequest.h"

#import "SBJsonParser.h"

@implementation HYZDMMessageRequest

- (void)DMMessageRequest:(NSString *)urlString{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        HYZDMMessageModel *model = [[HYZDMMessageModel alloc]initWithDictionary:dic error:nil];
        if ([model.status isEqualToString:@"success"]) {
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            if ([_delegate respondsToSelector:@selector(getDMMessageSuccess:mainmsgDictionary:)]) {
                [_delegate getDMMessageSuccess:[jsonParser objectWithString:model.bmsg] mainmsgDictionary:[jsonParser objectWithString:model.mainmsg]];
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
