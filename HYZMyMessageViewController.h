//
//  HYZMyMessageViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZMessageCell.h"

#import "HYZMessageRequest.h"

#import "HYZReadMessageRequest.h"

#import "HYZMessageCenterViewController.h"

@interface HYZMyMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HYZMessageRequestDelegate,HYZReadMessageRequestDelegate>

@property (nonatomic, strong) UITableView        *messageTableView;

@property (nonatomic, strong) HYZMessageRequest  *request;

@property (nonatomic, strong) NSArray            *messageArray;

@property (nonatomic, strong) NSArray            *hasArray;

- (void)creatMessageTableView;

- (void)newMessgeRequestUserName:(NSString *)aString;

- (void)getUserMessageRequest;

@end
