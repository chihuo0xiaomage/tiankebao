//
//  HYZSureViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NKDEAN13Barcode.h"

#import "UIImage-NKDBarcode.h"

#import "HYZSureTopView.h"

#import "HYZSettlementCell.h"

#import "HYZShoppingCarModel.h"

@interface HYZSureViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSString    *barCodeNUmberString;

@property (nonatomic, strong) NSString    *allNumberString;

@property (nonatomic, strong) NSString    *moneyString;

@property (nonatomic, strong) UITableView *sureTableView;

@property (nonatomic, strong) NSArray     *messageArray;

@end
