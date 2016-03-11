//
//  HYZCardTransactionViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZCardTransactionCell.h"

#import "HYZScrollViewCell.h"

@interface HYZCardTransactionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZCardTransactionCellDelegate,HYZScrollViewCellDelegate>

@property (nonatomic, strong) UITableView    *cardTaansactionTabView;

@property (nonatomic, strong) NSArray        *imageNameArray;

@property (nonatomic, strong) NSArray        *titleArray;

@end
