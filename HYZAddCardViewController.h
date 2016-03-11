//
//  HYZAddCardViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLoginTextView.h"

#import "HYZLinkMoreCardRequest.h"

#import "HYZGetCardTokenRequest.h"

@interface HYZAddCardViewController : UIViewController<UITextFieldDelegate,HYZLinkMoreCardRequestDelegate,HYZGetCardTokenRequestDelegate>

@property (nonatomic, strong) HYZLoginTextView        *cardNumberTextField;

@property (nonatomic, strong) HYZLoginTextView        *passwordTextField;

@property (nonatomic, strong) HYZLinkMoreCardRequest  *request;

- (void)creatTwoTextField;

- (void)creatLinkButton;

- (void)opinionCardNumerAndPassword;

@end
