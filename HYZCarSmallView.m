//
//  HYZCarSmallView.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCarSmallView.h"

@implementation HYZCarSmallView

@synthesize numberLable = _numberLable, priceLable = _priceLable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
//    总数量
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 40)];
    
    lable.text = @"总数量";
    
    [self addSubview:lable];
    
//    显示总数量
    _numberLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 80, 40)];
    
    _numberLable.textColor = [UIColor redColor];
    
    _numberLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_numberLable];
    
    
//    总金额
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 60, 40)];
    
    lable1.text = @"总金额";
    
    [self addSubview:lable1];
    
    
//    显示总金额
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 40)];
    
    _priceLable.textColor = [UIColor redColor];
    
    _priceLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_priceLable];
    
    
    UIButton *scanbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    scanbutton.frame = CGRectMake(20, 44, 120, 40);
    
    [scanbutton setBackgroundColor:[UIColor colorWithRed:169.0/255.0 green:169.0/255.0 blue:169.0/255.0 alpha:0.9]];
    
    [scanbutton setTitle:@"扫条码" forState:UIControlStateNormal];
    
    [scanbutton addTarget:self action:@selector(scanButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:scanbutton];
    
    
    UIButton *accountbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    accountbutton.frame = CGRectMake(180, 44, 120, 40);
    
    [accountbutton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    [accountbutton setTitle:@"结算" forState:UIControlStateNormal];
    
    [accountbutton addTarget:self action:@selector(accountButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:accountbutton];
}

- (void)scanButtonClicked
{
    if ([_delegate respondsToSelector:@selector(scanbuttonClicke)]) {
        [_delegate scanbuttonClicke];
    }
}

- (void)accountButtonClicked
{
    if ([_delegate respondsToSelector:@selector(accountbuttonClicke)]) {
        [_delegate accountbuttonClicke];
    }
}

@end
