//
//  HYZSinaLoginViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZSinaLoginRequest.h"

#import "HYZLoginRequest.h"

#import "HYZReplaceTabBar.h"

#import "HYZLinkEmailViewController.h"

@interface HYZSinaLoginViewController : UIViewController<UIWebViewDelegate,HYZSinaLoginRequestDelegate,HYZLoginRequestDelegate>

@property (nonatomic, strong) UIWebView        *webView;

@property (nonatomic, strong) HYZLoginRequest  *request;

@end
