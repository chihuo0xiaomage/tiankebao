//
//  HYZFeedBackViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZFeedBackRequest.h"

@interface HYZFeedBackViewController : UIViewController<UITextViewDelegate,HYZFeedBackRequestDelegate>

@property (nonatomic, strong) UITextView          *feedbackTextView;

@property (nonatomic, strong) HYZFeedBackRequest  *request;

- (void)creatUI;

@end
