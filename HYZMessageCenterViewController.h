//
//  HYZMessageCenterViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZGetAllMessageRequest.h"

#import "HYZMessageDetailModel.h"

#import "HYZDMMessageCell.h"

#import "HYZCommentViewController.h"

#import "HYZDMMessageViewController.h"

@interface HYZMessageCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZGetAllMessageRequestDelegate,HYZDMMessageCellDelegate>

@property (nonatomic, strong) NSString              *codeString;

@property (nonatomic, strong) NSArray               *messageArray;

@property (nonatomic, strong) UITableView           *messageTableView;

@property (nonatomic, strong) HYZMessageDetailModel *messageModel;

- (void)creatMessageTableView;

- (void)sendRequest;

@end
