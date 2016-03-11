//
//  HYZPromotionCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZPromotionCell.h"



@implementation HYZPromotionCell

@synthesize smallImageView = _smallImageView;

@synthesize titleLable = _titleLable;

@synthesize activityImageView = _activityImageView;

@synthesize  titleTimeLable = _titleTimeLable;

@synthesize detailLable = _detailLable;

@synthesize begainTimeLable = _begainTimeLable;

@synthesize shareButton = _shareButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier headImage:(NSString *)nameString title:(NSString *)titleString
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = BACKGROUND_COLOR;
        
        [self creatUiheadImage:nameString title:titleString];
    }
    return self;
}

- (void)creatUiheadImage:(NSString *)nameString title:(NSString *)titleString
{
//    活动主题
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 320, 36)];
    
    _titleLable.backgroundColor = [UIColor whiteColor];
    
    _titleLable.textAlignment = NSTextAlignmentCenter;
    
    _titleLable.text = titleString;
    
    [self.contentView addSubview:_titleLable];
    
    
//    主题下边的小图片
    _smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 35, 35)];
    
    _smallImageView.image = [UIImage imageNamed:nameString];
    
    [self.contentView addSubview:_smallImageView];
    
    
//    活动图片
    _activityImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 320, 150)];
    
    [self.contentView addSubview:_activityImageView];
    
//    发布时间
    _titleTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 191, 320, 24)];
    
    _titleTimeLable.font = [UIFont systemFontOfSize:15];
    
    _titleTimeLable.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:_titleTimeLable];

//    详细信息
    _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 216, 320, 24)];
    
    _detailLable.backgroundColor = [UIColor whiteColor];
    
    _detailLable.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_detailLable];
    
//    活动时间
    _begainTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 241, 249, 23)];
    
    _begainTimeLable.backgroundColor = BACKGROUND_COLOR;
    
    _begainTimeLable.font = [UIFont systemFontOfSize:15];
    
    _begainTimeLable.textColor = [UIColor redColor];
    
    [self.contentView addSubview:_begainTimeLable];
    
    
//    分享按钮
     _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];

    [_shareButton setTitle:@"分享" forState:UIControlStateNormal];
    
    [_shareButton setBackgroundColor:BACKGROUND_COLOR];
    
    [_shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _shareButton.frame = CGRectMake(251, 241, 69, 23);
    
    [self.contentView addSubview:_shareButton];
}

- (void)shareButtonClicked:(UIButton *)sender
{
    if ([_cellDelegate respondsToSelector:@selector(shareButtonClicke:)]) {
        [_cellDelegate shareButtonClicke:sender];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
