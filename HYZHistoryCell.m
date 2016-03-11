//
//  HYZHistoryCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZHistoryCell.h"

@implementation HYZHistoryCell

@synthesize cardNoLable = _cardNoLable, dcardMoneyLable = _dcardMoneyLable, ddateLable = _ddateLable, dshopnameLable = _dshopnameLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier image:(UIImage *)image
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        卡图片
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 6, 18, 18)];

        imageView.image = image;
        
        [self.contentView addSubview:imageView];
        
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews
{
//    卡号
    _cardNoLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 230, 25)];
    
    [self.contentView addSubview:_cardNoLable];
    
    
//    消费金额
    _dcardMoneyLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, 230, 25)];
    
    [self.contentView addSubview:_dcardMoneyLable];
    
    
//    时间
    _ddateLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 230, 20)];
    
    _ddateLable.font = [UIFont systemFontOfSize:13];
    
    _ddateLable.textColor = [UIColor redColor];
    
    _ddateLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_ddateLable];
    
    
//    消费位置
    _dshopnameLable = [[UILabel alloc] initWithFrame:CGRectMake(240, 40, 80, 30)];
    
    [self.contentView addSubview:_dshopnameLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
