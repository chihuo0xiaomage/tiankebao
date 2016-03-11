//
//  HYZLinkEmailViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLinkEmailRequest.h"

#import "HYZEmailPSWViewController.h"

@interface HYZLinkEmailViewController : UIViewController<UITextFieldDelegate,HYZLinkEmailRequestDelegate>

@property (nonatomic, strong) UITextField           *emailTextField;

@property (nonatomic, strong) NSString              *qqUserId;

@property (nonatomic, strong) NSString              *token;

@end
