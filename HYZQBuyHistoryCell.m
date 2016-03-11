//
//  HYZQBuyHistoryCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZQBuyHistoryCell.h"

@implementation HYZQBuyHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    _barCodeLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 290, 20)];
    
    _barCodeLable.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:_barCodeLable];
    
    
    _moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 290, 20)];
    
    _moneyLable.font = [UIFont systemFontOfSize:13];
    
    _moneyLable.textColor = [UIColor redColor];
    
    [self.contentView addSubview:_moneyLable];
    
    
    
    _timeLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, 290, 20)];
    
    _timeLable.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:_timeLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
