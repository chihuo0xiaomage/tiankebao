//
//  HYZSettingCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZSettingCell.h"

#define CELLWIDTH    self.bounds.size.width

#define CELLHEIGHT   self.bounds.size.height

@implementation HYZSettingCell

@synthesize leftImageView = _leftImageView, cellLable = _cellLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI
{
//    前边的图片
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, CELLHEIGHT - 16, CELLHEIGHT - 16)];
    
    [self.contentView addSubview:_leftImageView];
    
//    cell上得leble
    _cellLable = [[UILabel alloc] initWithFrame:CGRectMake(CELLHEIGHT, 0, CELLWIDTH - CELLHEIGHT, CELLHEIGHT)];
    
    _cellLable.backgroundColor = [UIColor clearColor];
    
    _cellLable.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:_cellLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
