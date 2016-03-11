//
//  HYZMessageDMCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-10.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZMessageDMCell.h"

@implementation HYZMessageDMCell

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
//    子标题
    _childTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 30)];
        
    _childTitleLable.font = [UIFont systemFontOfSize:15.0];
    
    _childTitleLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_childTitleLable];
    
    
//    图片
    _childImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 30, 200, 300)];
    
    [self.contentView addSubview:_childImageView];
    
    
//    内容
    _nodeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 330, 300, 40)];
    
    _nodeLable.textAlignment = NSTextAlignmentCenter;
    
    _nodeLable.font = [UIFont systemFontOfSize:15.0];
    
    _nodeLable.lineBreakMode = NSLineBreakByCharWrapping;
    
    _nodeLable.numberOfLines =0;
    
    [self.contentView addSubview:_nodeLable];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
