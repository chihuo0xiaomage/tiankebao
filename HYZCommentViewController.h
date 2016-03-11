//
//  HYZCommentViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MNMRadioGroup.h"

#import "MNMRadioGroupValue.h"

#import "HYZDMCommentRequest.h"

@interface HYZCommentViewController : UIViewController<MNMRadioGroupDelegate,HYZDMCommentRequestDelegate>

@property (nonatomic, strong) MNMRadioGroup            *radioGroup;

@property (nonatomic, strong) UITextField              *yijianTF;

@property (nonatomic, strong) NSString                 *message_idString;

@property (nonatomic, strong) NSString                 *tenantCodeString;

@property (nonatomic, strong) NSString                 *pingjiaStr;

@property (nonatomic, strong) HYZDMCommentRequest      *commentRequest;

@end
