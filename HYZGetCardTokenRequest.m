//
//  HYZGetCardTokenRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-3.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZGetCardTokenRequest.h"

@implementation HYZGetCardTokenRequest

- (void)getCardToken:(NSString *)cardNumberString
{
    cardNumberString = [cardNumberString substringFromIndex:6];
    
    cardNumberString = [cardNumberString substringToIndex:5];
    
    NSString *urlString = [NSString stringWithFormat:@"%@card/open/api/getToken.do?uniqueCode=%@",URL_HTTP,cardNumberString];
    
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
        
        HYZGetCardTokenModel *model = [[HYZGetCardTokenModel alloc] initWithDictionary:dic error:nil];
        
        if ([model.result isEqualToString:@"true"]) {
            if ([_delegate respondsToSelector:@selector(getCardTokenSuccess:)])
            {
//                4D586EF2C3663D772A0C4D456E1ADF08
                [_delegate getCardTokenSuccess:model.token];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(getCardTokenFaild:)])
            {
                [_delegate getCardTokenFaild:@"请求失败"];
            }
        }
    }];
}

@end
