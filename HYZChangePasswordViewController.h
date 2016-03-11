//
//  HYZChangePasswordViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGetCardTokenRequest.h"

#import "HYZChangePasswordRequest.h"

@interface HYZChangePasswordViewController : UIViewController<UITextFieldDelegate,HYZGetCardTokenRequestDelegate,HYZChangePasswordRequestDelegate>

@property (nonatomic, strong) UITextField *cardNumberTextField;

@property (nonatomic, strong) UITextField *oldTextField;

@property (nonatomic, strong) UITextField *nowOneTextField;

@property (nonatomic, strong) UITextField *nowTwoTextField;

- (void)creatForeTextFidld;

@end
