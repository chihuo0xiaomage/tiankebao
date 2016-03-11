//
//  HYZMoneyChangeViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZHistoryCell.h"

#import "HYZMoneyChangeRequest.h"

#import "HYZMoneyChangeRequest.h"

#import "HYZMoneyChangeDetailModel.h"

#import "HYZGetCardTokenRequest.h"

@interface HYZMoneyChangeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZMoneyChangeRequestDelegate,HYZGetCardTokenRequestDelegate>

@property (nonatomic, strong) UITableView    *moneyChangeTableView;

@property (nonatomic, strong) NSArray        *moneyChangeArray;

@end
