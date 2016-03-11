//
//  HYZTopUpViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLoginTextView.h"

#import "HYZTopUpRequest.h"

#import "HYZOpinion.h"

#import "HYZOpinionCardRequest.h"







//#import "DataSigner.h"

@interface HYZTopUpViewController : UIViewController<HYZTopUpRequestDelegate,HYZOpinionDelegate,HYZOpinionCardRequestDelegate>

@property (nonatomic, strong) NSString             *cardNumberString;

@property (nonatomic, strong) NSString             *cardTokenString;

@property (nonatomic, strong) NSString             *DFANAMEString;

@property (nonatomic, strong) NSString             *DFANOString;

@property (nonatomic, strong) NSString             *typeString;

@property (nonatomic, strong) NSString             *detailString;

@property (nonatomic, strong) HYZLoginTextView     *pswTextView;

@property (nonatomic, strong) HYZLoginTextView     *moneyTextView;

@property (nonatomic, strong) NSString             *minValueString;

@property (nonatomic, strong) NSString             *maxValueString;

@property (nonatomic, strong) NSString             *transactionNumberString;

@property (nonatomic, strong) HYZOpinion           *opinion;

@property (nonatomic, assign) SEL                  _result;

//- (void)TopUpSuccess;
//
//- (void)TopUpFaild;

@end
