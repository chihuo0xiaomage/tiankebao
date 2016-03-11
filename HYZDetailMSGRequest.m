//
//  HYZDetailMSGRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZDetailMSGRequest.h"

#import "SBJsonParser.h"

@implementation HYZDetailMSGRequest

- (void)getShoppingDetailMessageRequset:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZDetailMSGModel *model = [[HYZDetailMSGModel alloc] initWithDictionary:dic error:nil];
        
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegare respondsToSelector:@selector(getShoppingDetailMessageSuccess:)]) {
                [_delegare getShoppingDetailMessageSuccess:[jsonParser objectWithString:model.message]];
            }
        }
        else{
            if ([_delegare respondsToSelector:@selector(requestFaild:)]) {
                [_delegare requestFaild:@"请求失败"];
            }
        }
    }];
}

@end
