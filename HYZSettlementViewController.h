//
//  HYZSettlementViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZTopView.h"

#import "HYZSettlementCell.h"

#import "HYZDownView.h"

#import "HYZSureViewController.h"

#import "HYZGetCardTokenRequest.h"

#import "HYZBalanceRequest.h"

#import "HYZDetailBalanceModel.h"

#import "HYZShopDetailRequest.h"

#import "HYZSaveConsumeRequest.h"

#import "HYZShoppCommitRequest.h"

@interface HYZSettlementViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZDownViewDelegate,HYZGetCardTokenRequestDelegate,HYZBalanceRequestDelegate,HYZShopDetailRequestDelegate,HYZSaveConsumeRequestDelegate,HYZShoppCommitRequestDelegate>

@property (nonatomic, strong) NSString       *numberStr;

@property (nonatomic, strong) NSString       *priceStr;

@property (nonatomic, strong) NSString       *cardNumberStr;

@property (nonatomic, strong) UITableView    *settlementTableView;

@property (nonatomic, strong) NSArray        *messageArray;

@end
