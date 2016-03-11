//
//  HYZWebViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYZWebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString       *urlString;

@property (nonatomic, strong) NSString       *titleString;

@property (nonatomic, strong) UIWebView      *webView;

@end
