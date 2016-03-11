//
//  HYZDMMessageViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZDMMessageRequest.h"

#import "HYZMessageDMCell.h"

@interface HYZDMMessageViewController : UIViewController<HYZDMMessageRequestDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView              *DMMessageTableView;

@property (nonatomic, strong) NSString                 *idString;

@property (nonatomic, strong) NSArray                  *childMessageArray;

@property (nonatomic, strong) NSDictionary             *mainMessageDictionary;

@end
