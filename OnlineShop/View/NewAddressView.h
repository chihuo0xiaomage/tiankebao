//
//  NewAddressView.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AreaView;
@interface NewAddressView : UIView<UITextFieldDelegate>

@property(nonatomic, strong)UILabel * label;
@property(nonatomic, strong)UITextField * textField;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UIButton * button;

@property(nonatomic, strong)AreaView * provinceView;
@property(nonatomic, strong)AreaView * cityView;
@property(nonatomic, strong)AreaView * countyView;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder;
- (id)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;
@end
