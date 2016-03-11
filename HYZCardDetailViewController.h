//
//  HYZCardDetailViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGetCardTokenRequest.h"

#import "HYZCardDetailMessageRequest.h"

#import "HYZCardDetailModel.h"

#import <QuartzCore/QuartzCore.h>

#import "HYZRelieveRequest.h"

#import "HYZSettingDefaultCardRequest.h"

@interface HYZCardDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZGetCardTokenRequestDelegate,HYZCardDetailMessageRequestDelegate,HYZRelieveRequestDelegate,HYZSettingDefaultCardRequestDelegate>

@property (nonatomic, strong) NSString           *cardNumberString;

@property (nonatomic, strong) UITableView        *cardDetailTableView;

@property (nonatomic, strong) HYZCardDetailModel *detailModel;

@property (nonatomic, strong) UIButton           *rightButton;

@property (nonatomic, strong) NSString           *defaultString;

- (void)creatMyTableView;

@end
