//
//  HYZPromotionDetainMessageRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZPromotionDetainMessageRequest.h"

#import "JSONHTTPClient.h"

#import "SBJson.h"

@implementation HYZPromotionDetainMessageRequest

- (id)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
            
            NSString *statusString = [dic objectForKey:@"status"];
            
            NSString *messageString = [dic objectForKey:@"message"];
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            
            NSArray *messageArray = [jsonParser objectWithString:messageString];
            
            if ([statusString isEqualToString:@"success"]) {
                if ([_delegate respondsToSelector:@selector(getMessageSuccess:)]) {
                    [_delegate getMessageSuccess:messageArray];
                }
            }
            else{
                if ([_delegate respondsToSelector:@selector(getMessageFaild:)]) {
                    [_delegate getMessageFaild:@"加载失败"];
                }
            }
        }];
        
    }
    return self;
}


@end
