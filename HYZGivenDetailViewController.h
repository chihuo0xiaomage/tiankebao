//
//  HYZGivenDetailViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLoginTextView.h"

#import "HYZTopUpViewController.h"

#import "HYZGivenDetailRequest.h"

@interface HYZGivenDetailViewController : UIViewController<HYZGivenDetailRequestDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIButton             *detailButton;

@property (nonatomic, strong) NSString             *cardNumberString;

@property (nonatomic, strong) NSString             *cardTokenString;

@property (nonatomic, strong) NSString             *DFANAMEString;

@property (nonatomic, strong) NSString             *DFANOString;

@property (nonatomic, strong) NSString             *typeString;

@property (nonatomic, strong) NSArray              *dataMessageArray;

@end
