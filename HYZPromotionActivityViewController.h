//
//  HYZPromotionActivityViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZTopCell.h"

#import "HYZSettingCell.h"

#import "HYZWebViewController.h"

@interface HYZPromotionActivityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView           *convenienceTableView;

@property (nonatomic, strong) NSArray               *itemNameArray;

@property (nonatomic, strong) NSArray               *itemImageArray;

@end
