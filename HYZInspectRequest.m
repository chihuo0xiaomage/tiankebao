//
//  HYZInspectRequest.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZInspectRequest.h"

#import "SBJson.h"

@implementation HYZInspectRequest

- (void)updata:(NSString *)urlString
{
    [JSONHTTPClient postJSONFromURLWithString:urlString bodyData:nil completion:^(NSDictionary *dic , JSONModelError *error){
            //NSLog(@"dic = %@", dic);
        int resultCount = [[dic objectForKey:@"resultCount"] intValue];
        NSString *versionString = [[[dic objectForKey:@"results"] objectAtIndex:0] objectForKey:@"version"];
        if(resultCount>0)
        {
            if ([_delegate respondsToSelector:@selector(getVersionSuccess:)]) {
                [_delegate getVersionSuccess:versionString];
            }
        }
        else
        {
            if ([_delegate respondsToSelector:@selector(getVersionFaild:)]) {
                [_delegate getVersionFaild:@"请求失败"];
            }
        }
        
    }];
}

@end
