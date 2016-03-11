//
//  HYZReportMyCardViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGetCardTokenRequest.h"

#import "HYZReportRequest.h"

@interface HYZReportMyCardViewController : UIViewController<UITextFieldDelegate,HYZGetCardTokenRequestDelegate,HYZReportRequestDelegate>

@property (nonatomic, strong) UITextField *cardNumberTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@end
