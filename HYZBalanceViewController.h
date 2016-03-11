//
//  HYZBalanceViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZBalanceRequest.h"

#import "HYZDetailBalanceModel.h"

#import "HYZGetCardTokenRequest.h"

@interface HYZBalanceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZBalanceRequestDelegate,HYZGetCardTokenRequestDelegate>

@property (nonatomic, strong) UITableView              *balanceTableView;

@property (nonatomic, strong) HYZDetailBalanceModel    *detailBalanceModel;

@end
