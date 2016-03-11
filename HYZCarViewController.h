//
//  HYZCarViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGoodMessageRequest.h"

#import "HYZCarCell.h"

#import "HYZCarModel.h"

#import "HYZUITapGestureRecognizer+Tag.h"

#import "HYZShoppingCarModel.h"

#import "HYZCarSmallView.h"

#import "ZBarSDK.h"

#import "HYZSettlementViewController.h"

#import "HYZLoginViewController.h"

@interface HYZCarViewController : UIViewController<HYZGoodMessageRequestDelegate,UITableViewDataSource,UITableViewDelegate,HYZCarCellDelegate,HYZCarSmallViewDelegate,ZBarReaderDelegate>

@property (nonatomic, strong) NSString             *barCodeString;

@property (nonatomic, strong) NSMutableArray       *messageArray;

@property (nonatomic, strong) UITableView          *myTableView;

@end
