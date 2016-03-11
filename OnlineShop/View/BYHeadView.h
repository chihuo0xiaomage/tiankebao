//
//  BYHeadView.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYHeadView : UIView
@property(nonatomic, strong)NSTimer * timer;
@property(nonatomic, strong)UILabel * promptLabel;
@property(nonatomic, strong)UILabel * startLabel;
@property(nonatomic, strong)UILabel * HLabel;
@property(nonatomic, strong)UILabel * label;
@property(nonatomic, strong)UILabel * MLabel;
@property(nonatomic, strong)UILabel * SLabel;
@property(nonatomic, strong)NSDictionary * dic;
@property(nonatomic, assign)BOOL      begin;
@end
