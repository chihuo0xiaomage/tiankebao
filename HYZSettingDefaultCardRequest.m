//
//  HYZSettingDefaultCardRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSettingDefaultCardRequest.h"

@implementation HYZSettingDefaultCardRequest

- (void)settingThisCardToDefaultReequest:(NSString *)urlString isDefaultString:(NSString *)defaultString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic, JSONModelError *error){
        
        HYZSettingDefaultCardModel *model = [[HYZSettingDefaultCardModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.status isEqualToString:@"success"]) {
            if ([_delegate respondsToSelector:@selector(settingSuccess:isDefaultString:)]) {
                [_delegate settingSuccess:model.message isDefaultString:defaultString];
            }
        }
        else{
            if ([_delegate respondsToSelector:@selector(requestFaild:)]) {
                [_delegate requestFaild:@"设置失败"];
            }
        }
    }];
}

@end
