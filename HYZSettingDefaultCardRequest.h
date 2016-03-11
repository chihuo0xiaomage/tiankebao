//
//  HYZSettingDefaultCardRequest.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONHTTPClient.h"

#import "HYZSettingDefaultCardModel.h"

@protocol HYZSettingDefaultCardRequestDelegate <NSObject>

- (void)settingSuccess:(NSString *)successString isDefaultString:(NSString *)defaultString;

- (void)requestFaild:(NSString *)faildString;

@end

@interface HYZSettingDefaultCardRequest : NSObject

@property (nonatomic, assign) id <HYZSettingDefaultCardRequestDelegate> delegate;

- (void)settingThisCardToDefaultReequest:(NSString *)urlString isDefaultString:(NSString *)defaultString;

@end
