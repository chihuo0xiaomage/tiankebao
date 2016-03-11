//
//  HYZMainViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZCardTransactionCell.h"

#import "HYZScrollViewCell.h"

#import "HYZSearchView.h"

#import "HYZCustemItem.h"

#import "HYZMessageViewController.h"

#import "HYZConveniencePeopleViewController.h"

@interface HYZMainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZCardTransactionCellDelegate,HYZScrollViewCellDelegate>

@property (nonatomic, strong) UITableView    *cardTaansactionTabView;
@property (nonatomic, strong) NSArray        *imageNameArray;
@property (nonatomic, strong) NSArray        *scrollViewImageArray;
@property (nonatomic, strong) NSArray        *titleArray;

- (void)creatUI;

@end
