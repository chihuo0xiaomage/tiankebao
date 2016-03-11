//
//  HYZSettingViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZSettingCell.h"

#import "HYZTopCell.h"

#import "HYZChangePSWViewController.h"

#import "HYZFeedBackViewController.h"

#import "HYZAboutViewController.h"

#import "HYZQuit.h"

#import "HYZInspectRequest.h"

#import "HYZRecommendViewController.h"

#import "HYZReplaceTabBar.h"



@interface HYZSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) NSArray          *itemNameArray;

@property (nonatomic, strong) NSArray          *itemImageArray;

@end
