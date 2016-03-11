//
//  HYZDetailMessageViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZPromotionDetainMessageRequest.h"

#import "HYZDetailmessageModel.h"

#import "HYZPromotionDetailCell.h"

#import "AWActionSheet.h"


@interface HYZDetailMessageViewController : UIViewController<HYZPromotionDetainMessageRequestDelegate,UITableViewDataSource,UITableViewDelegate,HYZPromotionDetailCellDelegate,AWActionSheetDelegate>

@property (nonatomic, strong) NSString     *messageIdString;

@property (nonatomic, strong) NSArray      *detailMessageArray;

@property (nonatomic, strong) UITableView  *promotionTablleView;



@end
