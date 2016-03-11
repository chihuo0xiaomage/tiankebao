//
//  HYZPromotionDetailCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZPromotionDetailCell.h"

@implementation HYZPromotionDetailCell

@synthesize smallpromotionLable = _smallpromotionLable;

@synthesize smallImageView = _smallImageView;

@synthesize titleLable = _titleLable;

@synthesize activityImageView = _activityImageView;

@synthesize  themeLable = _themeLable;

@synthesize detailLable = _detailLable;

@synthesize begainTimeLable = _begainTimeLable;

@synthesize shareButton = _shareButton;

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
    _smallpromotionLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    
    _smallpromotionLable.backgroundColor = [UIColor whiteColor];
    
    _smallpromotionLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_smallpromotionLable];
    
    
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 320, 35)];
    
    _titleLable.backgroundColor = [UIColor whiteColor];
    
    _themeLable.font = [UIFont systemFontOfSize:15];
    
    _titleLable.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_titleLable];
    
    
    
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 1, 35, 33)];
    
    [self.contentView addSubview:_smallImageView];
    
    
    
    _activityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 150)];
    
    [self.contentView addSubview:_activityImageView];
    
    
    _themeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 211, 320, 24)];
    
    _themeLable.font = [UIFont systemFontOfSize:15];
    
    _themeLable.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_themeLable];
    
    
    _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 236, 320, 149)];
    
    _detailLable.backgroundColor = [UIColor whiteColor];
    
    _detailLable.numberOfLines = 0;
    
    _detailLable.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_detailLable];
    
    
    _begainTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 385, 249, 23)];
    
    _begainTimeLable.backgroundColor = BACKGROUND_COLOR;
    
    _begainTimeLable.font = [UIFont systemFontOfSize:15];
    
    _begainTimeLable.textColor = [UIColor redColor];
    
    [self.contentView addSubview:_begainTimeLable];
    
    
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    [_shareButton setBackgroundColor:BACKGROUND_COLOR];
    
    [_shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _shareButton.frame = CGRectMake(251, 385, 69, 23);
    
    [self.contentView addSubview:_shareButton];
}

- (void)shareButtonClicked:(UIButton *)sender
{
    if ([_cellDelegate respondsToSelector:@selector(share:)]) {
        [_cellDelegate share:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
