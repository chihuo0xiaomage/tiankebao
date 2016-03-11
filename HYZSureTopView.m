//
//  HYZSureTopView.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSureTopView.h"

@implementation HYZSureTopView

@synthesize barCodeLable = _barCodeLable, numberLable=_numberLable, moneyLable=_moneyLable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
    UILabel *transactionLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 90, 20)];
    
    transactionLable.text = @"交易编号:";
    
    [self addSubview:transactionLable];
    
    
//    交易编号
    _barCodeLable = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 200, 20)];
    
    _barCodeLable.textColor = [UIColor redColor];
    
    _barCodeLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_barCodeLable];
    
    
    UILabel *allNumberLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 70, 20)];
    
    allNumberLable.text = @"总数量(件)";
    
    allNumberLable.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:allNumberLable];
    
    
//    数量
    _numberLable = [[UILabel alloc] initWithFrame:CGRectMake(85, 25, 50, 20)];
    
    _numberLable.textColor = [UIColor redColor];
    
    _numberLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_numberLable];
    
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(135, 25, 70, 20)];
    
    priceLable.text = @"金额(元)";
    
    priceLable.font = [UIFont systemFontOfSize:15];
    
    [self addSubview:priceLable];
    
    
//    金额
    _moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(205, 25, 85, 20)];
    
    _moneyLable.textColor = [UIColor redColor];
    
    _moneyLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_moneyLable];
    
    
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 45, 95, 20)];
    
    
    nameLable.text = @"物品名";
    
    [self addSubview:nameLable];
    
    
    
    UILabel *shuLiangLable = [[UILabel alloc] initWithFrame:CGRectMake(110, 45, 100, 20)];
    
    
    shuLiangLable.text = @"数量(件)";
    
    shuLiangLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:shuLiangLable];
    
    
    
    UILabel *jinELable = [[UILabel alloc] initWithFrame:CGRectMake(210, 45, 95, 20)];
    
    jinELable.text = @"金额(元)";
    
    jinELable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:jinELable];
}

@end
