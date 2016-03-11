//
//  HYZQBuyHistoryViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZQBuyHistoryCell.h"

#import "HYZQ-BuyHistoryRequest.h"

#import "HYZQBuyDetailModel.h"

#import "HYZHisToryDetailViewController.h"

@interface HYZQBuyHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,HYZQ_BuyHistoryRequestDelegate>

@property (nonatomic, strong) UITableView          *historyTableView;

@property (nonatomic, strong) NSArray              *messageArray;

@end
