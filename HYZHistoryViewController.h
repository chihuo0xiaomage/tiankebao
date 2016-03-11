//
//  HYZHistoryViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZHistoryCell.h"

#import "HYZHistoryRequest.h"

#import "HYZHistoryDetailMessageModel.h"

#import "HYZGetCardTokenRequest.h"

@interface HYZHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZHistoryRequestDelegate,HYZGetCardTokenRequestDelegate>

@property (nonatomic, strong) UITableView    *historyTableView;

@property (nonatomic, strong) NSArray        *historyMessageArray;

@end
