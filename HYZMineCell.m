//
//  HYZMineCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZMineCell.h"

@implementation HYZMineCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier headPortraitImage:(NSString *)imageString userName:(NSString *)nameString CardNumber:(NSString *)numberString
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    [self creatUiHeadPortraitImage:imageString userName:nameString CardNumber:numberString];
    
    return self;
}

- (void)creatUiHeadPortraitImage:(NSString *)imageString userName:(NSString *)nameString CardNumber:(NSString *)numberString
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 80)];
    
    backgroundImageView.image = [UIImage imageNamed:@"wode_icon_top.png"];;
    
    [self.contentView addSubview:backgroundImageView];
    
    
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
    
    headImageView.image = [UIImage imageNamed:imageString];
    
    headImageView.backgroundColor = [UIColor grayColor];
    
    [self.contentView addSubview:headImageView];
    
    
    UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 260, 25)];
    
    nameLable.text = [NSString stringWithFormat:@"用户名:%@",nameString];
    
    nameLable.backgroundColor = [UIColor clearColor];
    
    nameLable.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:nameLable];
    
    
    UILabel *numberLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 260, 25)];
    
    numberLable.text = [NSString stringWithFormat:@"当前卡:%@",numberString];
    
    numberLable.backgroundColor = [UIColor clearColor];
    
    numberLable.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:numberLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
