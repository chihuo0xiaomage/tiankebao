//
//  HYZSettlementCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSettlementCell.h"

@implementation HYZSettlementCell

@synthesize nameLable = _nameLable, numberLable = _numberLable, priceLable = _priceLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatLables];
    }
    return self;
}

- (void)creatLables
{
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 110, 50)];
    
    _nameLable.font = [UIFont systemFontOfSize:15];
    
    _nameLable.lineBreakMode = NSLineBreakByWordWrapping;
        
    _nameLable.numberOfLines = 0;
    
    [self.contentView addSubview:_nameLable];
    
    
    _numberLable = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, 80, 50)];
    
    _numberLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_numberLable];
    
    
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(230, 0, 80, 50)];
    
    _priceLable.textColor = [UIColor redColor];
    
    _priceLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_priceLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
