//
//  HYZLoginViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLoginTextView.h"

#import "HYZLoginButton.h"

#import "HYZLoginRequest.h"

#import "HYZMainViewController.h"

#import "HYZPromotionViewController.h"

#import "HYZShoppingCarViewController.h"

#import "HYZServeViewController.h"

#import "HYZMineViewController.h"

#import "HYZRegisterViewController.h"

#import "HYZForgetPSWViewController.h"

#import "HYZLinkEmailViewController.h"

#import "HYZReplaceTabBar.h"

@protocol HYZLoginViewControllerDelegate <NSObject>

- (void)loginSuccess;

@end

@interface HYZLoginViewController : UIViewController<HYZLoginButtonDelegate,HYZLoginRequestDelegate,UITabBarControllerDelegate>

@property (nonatomic, strong) id                   delegate;

@property (nonatomic, strong) NSArray              *permissions;

@property (nonatomic, strong) HYZLoginRequest      *request;

@property (nonatomic, strong) HYZLoginTextView     *userTextView;

@property (nonatomic, strong) HYZLoginTextView     *pswTextView;

- (void)creatTextField;

- (void)creatButton;

@end
