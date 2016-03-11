//
//  HYZPromotionViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZPromotionCell.h"

#import "HYZPromotionModel.h"

#import "HYZDetailMessageViewController.h"

#import "HYZPromotionRequest.h"

#import "AWActionSheet.h"


@interface HYZPromotionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZPromotionRequestDelegate,HYZPromotionCellDelegate,AWActionSheetDelegate>

@property (nonatomic, strong) NSArray               *messageArray;

@property (nonatomic, strong) UITableView           *promotionTablleView;



- (void)creatMyTableView;

@end
