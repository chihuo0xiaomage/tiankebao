//
//  HYZForgetPSWViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLoginTextView.h"

#import "HYZForgetPasswordRequest.h"

@interface HYZForgetPSWViewController : UIViewController<HYZForgetPasswordRequestDelegate>

@property (nonatomic, strong) HYZLoginTextView      *emailTextView;

@end
