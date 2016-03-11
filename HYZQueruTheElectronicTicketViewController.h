//
//  HYZQueruTheElectronicTicketViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZHistoryCell.h"

#import "HYZGetCardTokenRequest.h"

#import "HYZQueryTheElectronicTicketRequest.h"

#import "HYZQueryTheElectronicTicketDataListModel.h"

@interface HYZQueruTheElectronicTicketViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZGetCardTokenRequestDelegate,HYZQueryTheElectronicTicketRequestDelegate>

@property (nonatomic, strong) UITableView        *myTableView;

@property (nonatomic, strong) NSArray            *messageArray;

@end
