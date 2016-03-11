//
//  HYZCarSmallView.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYZCarSmallViewDelegate <NSObject>

- (void)scanbuttonClicke;

- (void)accountbuttonClicke;

@end

@interface HYZCarSmallView : UIView

@property (nonatomic, assign) id <HYZCarSmallViewDelegate>   delegate;

@property (nonatomic, strong) UILabel                        *numberLable;

@property (nonatomic, strong) UILabel                        *priceLable;

@end
