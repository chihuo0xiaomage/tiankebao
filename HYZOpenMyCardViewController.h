//
//  HYZOpenMyCardViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGetCardTokenRequest.h"

#import "HYZOpenRequest.h"

@interface HYZOpenMyCardViewController : UIViewController<UITextFieldDelegate,HYZGetCardTokenRequestDelegate,HYZOpenRequestDelegate>

@property (nonatomic, strong) UITextField *cardNumberTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@end
