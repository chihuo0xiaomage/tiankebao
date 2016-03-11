//
//  HYZGivenTypeViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGivenTypeRequest.h"

#import "HYZLoginTextView.h"

#import "HYZGivenDetailViewController.h"

@interface HYZGivenTypeViewController : UIViewController<HYZGivenTypeRequestDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSString             *cardNoString;

@property (nonatomic, strong) NSString             *cardTokenString;

@property (nonatomic, strong) NSString             *DFANAMEString;

@property (nonatomic, strong) NSString             *DFANOString;

@property (nonatomic, strong) HYZLoginTextView     *cardNumberTextView;

@property (nonatomic, strong) UIButton             *typeButton;

@property (nonatomic, strong) NSArray              *dataListArray;

@end
