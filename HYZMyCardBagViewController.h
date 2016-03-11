//
//  HYZMyCardBagViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZCardBagRequest.h"

#import "HYZCardBagMessageModel.h"

#import "HYZCardDetailViewController.h"

#import "HYZAddCardViewController.h"

@interface HYZMyCardBagViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZCardBagRequestDelegate>

@property (nonatomic, strong) UITableView              *cardBagTableView;

@property (nonatomic, strong) NSArray                  *messageArray;

- (void)creatATableView;

- (void)getUserAllCard;

@end
