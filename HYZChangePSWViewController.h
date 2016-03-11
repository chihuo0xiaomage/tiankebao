//
//  HYZChangePSWViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZLoginTextView.h"

#import "HYZChangePSWRequest.h"

@interface HYZChangePSWViewController : UIViewController<HYZChangePSWRequestDelegate>

@property (nonatomic,strong) HYZLoginTextView    *oldTextField;

@property (nonatomic,strong) HYZLoginTextView    *nowOneTextField;

@property (nonatomic,strong) HYZLoginTextView    *nowTwoTextField;

- (void)creatTextField;

@end
