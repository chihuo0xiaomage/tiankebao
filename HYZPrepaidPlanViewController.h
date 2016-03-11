//
//  HYZPrepaidPlanViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-12.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGetCardDetailModel.h"

#import "HYZGetCardTokenRequest.h"

#import "MBProgressHUD.h"

#import "HYZPrepaidPlanRequest.h"

#import "HYZLoginTextView.h"

#import "HYZGivenTypeViewController.h"

@interface HYZPrepaidPlanViewController : UIViewController<HYZGetCardTokenRequestDelegate,HYZPrepaidPlanRequestDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSString          *tokenString;

@property (nonatomic, strong) NSString          *cardNoString;

@property (nonatomic, strong) NSString          *DFANAMEString;

@property (nonatomic, strong) NSString          *DFANOString;

@property (nonatomic, strong) UIButton          *prepaildPlanButton;

@property (nonatomic, strong) HYZLoginTextView  *cardNumberTextView;

@property (nonatomic, strong) NSArray           *prepaildPlanArray;

@end
