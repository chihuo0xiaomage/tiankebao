//
//  HYZTopView.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZTopView.h"

@implementation HYZTopView

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
    UILabel *numberLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 60, 30)];
    
    numberLB.text = @"总数量(件)";
    
    numberLB.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:numberLB];
    
    
//    商品总数量
    _numberLable =[[UILabel alloc] initWithFrame:CGRectMake(80, 0, 80, 30)];
    
    _numberLable.textColor = [UIColor redColor];
    
    _numberLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_numberLable];
    
    
    UILabel *priceLB = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 60, 30)];
    
    priceLB.text = @"总金额(元)";
    
    priceLB.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:priceLB];
    
    
//    总价格
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 30)];
    
    _priceLable.textColor = [UIColor redColor];
    
    _priceLable.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_priceLable];
    
    
    UILabel *goodNameLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 110, 30)];
    
    goodNameLB.text = @"物品名";
    
    [self addSubview:goodNameLB];
    
    
    UILabel *goodNumberLB = [[UILabel alloc] initWithFrame:CGRectMake(135, 30, 80, 30)];
    
    goodNumberLB.text = @"数量(件)";
    
    goodNumberLB.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:goodNumberLB];
    
    
    UILabel *goodPriceLB = [[UILabel alloc] initWithFrame:CGRectMake(230, 30, 80, 30)];
    
    goodPriceLB.text = @"金额(元)";
    
    goodPriceLB.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:goodPriceLB];
    
}

@end
