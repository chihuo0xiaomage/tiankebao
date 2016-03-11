//
//  HYZEmailPSWViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLinkEmailPasswordRequest.h"

#import "HYZGetUserMessageRequest.h"

#import "HYZLoginRequest.h"

#import "HYZReplaceTabBar.h"

@interface HYZEmailPSWViewController : UIViewController<UITextFieldDelegate,HYZLinkEmailPasswordRequestDelegate,HYZGetUserMessageRequestDelegate,HYZLoginRequestDelegate>

@property (nonatomic, strong) UITextField           *emailPasswrodTextField;

@property (nonatomic, strong) NSString              *accessTokenString;

@property (nonatomic, strong) NSString              *userIdString;

@property (nonatomic, strong) NSString              *emailString;

@end
