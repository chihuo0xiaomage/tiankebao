//
//  HYZPromotionRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZPromotionRequest.h"

@implementation HYZPromotionRequest

- (id)initWithUrlString:(NSString *)urlString
{
    self = [super init];
    if (self) {
        [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
            
            NSString *messageString = [dic objectForKey:@"message"];
            
            NSString *statusString = [dic objectForKey:@"status"];
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            
            NSArray *messageArray = [jsonParser objectWithString:messageString];
            
            if ([statusString isEqualToString:@"success"])
            {
                if ([_delegate respondsToSelector:@selector(getmessageSuccess:)]) {
                    [_delegate getmessageSuccess:messageArray];
                }
            }
            else{
                if ([_delegate respondsToSelector:@selector(getmessageFaild:)]) {
                    [_delegate getmessageFaild:@"加载失败"];
                }
            }
        }];
        
    }
    return self;
}

@end
