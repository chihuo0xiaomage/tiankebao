//
//  HYZMineViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZMineCell.h"

#import "HYZSettingViewController.h"

#import "HYZQBuyHistoryViewController.h"

#import "HYZMyCalendarViewController.h"

#import "HYZMyMessageViewController.h"

#import "HYZMyCardBagViewController.h"

#import "HYZGetCardRequest.h"

#import "HYZGetCardDetailModel.h"

@interface HYZMineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZGetCardRequestDelegate>

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) NSArray *cardArray;

@property (nonatomic, strong) UITableView *itemTableView;

@end
