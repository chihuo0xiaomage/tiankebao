//
//  HYZMessageCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMessageCell.h"

@implementation HYZMessageCell

@synthesize leftImageView = _leftImageView;

@synthesize rightImageView = _rightImageView;

@synthesize shopNameLable = _shopNameLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView
{
//     商家logo图片
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 56, 56)];
    
    [self.contentView addSubview:_leftImageView];
    
    
//     商家
    _shopNameLable = [[UILabel alloc] initWithFrame:CGRectMake(65, 2, 255, 56)];
    
    [self.contentView addSubview:_shopNameLable];
    
    
//    有新消息，需要显示的图片
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 40, 40, 20)];
    
    [self.contentView addSubview:_rightImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
