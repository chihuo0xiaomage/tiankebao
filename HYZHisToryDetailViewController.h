//
//  HYZHisToryDetailViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZDetailMSGRequest.h"

#import "NKDEAN13Barcode.h"

#import "UIImage-NKDBarcode.h"

#import "HYZSettlementCell.h"

#import "HYZSureTopView.h"

#import "HYZConsumeDetailModel.h"

@interface HYZHisToryDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZDetailMSGRequestDelegate>

@property (nonatomic, strong) NSString            *barCodeString;

@property (nonatomic, strong) UITableView         *messageTableView;

@property (nonatomic, strong) NSArray             *messageArray;

@property (nonatomic, strong) HYZSureTopView      *topView;

@end
