//
//  HYZDMMessageCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZDMMessageCell.h"

#import "HYZUITapGestureRecognizer+Tag.h"

@implementation HYZDMMessageCell

@synthesize titleLable = _titleLable;

@synthesize messageLable = _messageLable;

@synthesize createDateLable = _createDateLable;

@synthesize tenantcodeLable = _tenantcodeLable;

@synthesize dmImageView = _dmImageView;

@synthesize pingjiaLale = _pingjiaLale;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier image:(UIImage *)image tag:(NSString *)tag height:(float)height messageType:(int)type
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            [self creatUiImage:image tag:tag height:height messageType:type];
    }
    return self;
}

- (void)creatUiImage:(UIImage *)image tag:(NSString *)tag height:(float)height messageType:(int)type
{
    HYZBackgroundImageView *backgroundImageView = [[HYZBackgroundImageView alloc] initWithFrame:CGRectMake(10, 0, 300, height) image:image tag:tag];
    
    backgroundImageView.delegate = self;
    
    [self.contentView addSubview:backgroundImageView];
    
    if (type == 8) {[self creatCellSubviews:backgroundImageView];}
    
    else if (type == 0){[self creatNormalCellSubviews:backgroundImageView height:height];}
    else{[self creatSpecialCellSubviews:backgroundImageView height:height];}
}

- (void)creatCellSubviews:(UIImageView *)imageView
{
//     活动主题
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 280, 20)];
    
    _titleLable.font = [UIFont systemFontOfSize:15];
    
    [imageView addSubview:_titleLable];
    
//    消息内容
    _messageLable = [[STTweetLabel alloc] initWithFrame:CGRectMake(10, 40, 280, 20)];
    
    _messageLable.font = [UIFont systemFontOfSize:15];
    
    [imageView addSubview:_messageLable];
    

//    DM消息的首界面
    _dmImageView = [[UIImageView alloc] initWithFrame:CGRectMake(70, 60, 160, 210)];
    
    [imageView addSubview:_dmImageView];
    
    
//    线
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_1.png"]];
    
    lineImageView.frame = CGRectMake(10, 275, 280, 1);
    
    [imageView addSubview:lineImageView];
    
//    日期
    _createDateLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 280, 180, 15)];
    
    _createDateLable.textColor = [UIColor redColor];

    
    _createDateLable.font = [UIFont systemFontOfSize:13];
    
    [imageView addSubview:_createDateLable];
    
    
//    商家
    _tenantcodeLable = [[UILabel alloc] initWithFrame:CGRectMake(190, 280, 100, 15)];
    
    _tenantcodeLable.font = [UIFont systemFontOfSize:14];
    
    [imageView addSubview:_tenantcodeLable];
}

- (void)creatNormalCellSubviews:(UIImageView *)imageView height:(float)height
{
//    活动主题
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 280, 20)];
    
    _titleLable.font = [UIFont systemFontOfSize:15];
    
    [imageView addSubview:_titleLable];
    
    
//    消息内容
    _messageLable = [[STTweetLabel alloc] initWithFrame:CGRectMake(10, 40, 280, height - 60)];
    
    [_messageLable setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0]];
    
    [_messageLable setTextColor:[UIColor blackColor]];
    
    _messageLable.numberOfLines = 0;
    
    _messageLable.lineBreakMode = NSLineBreakByWordWrapping;
    
    [_messageLable setDelegate:self];
    
    [imageView addSubview:_messageLable];
    
    
//    线
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_1.png"]];
    
    lineImageView.frame = CGRectMake(10, 40 + (height - 60) + 3, 280, 1);
    
    [imageView addSubview:lineImageView];
    
    
//    日期
    _createDateLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 40 + (height - 60) + 2, 180, 15)];
    
    _createDateLable.textColor = [UIColor redColor];
    
    
    _createDateLable.font = [UIFont systemFontOfSize:13];
    
    [imageView addSubview:_createDateLable];
    
    
//    商家
    _tenantcodeLable = [[UILabel alloc] initWithFrame:CGRectMake(190, 40 + (height - 60) + 2, 100, 15)];
    
    _tenantcodeLable.font = [UIFont systemFontOfSize:14];
    
    [imageView addSubview:_tenantcodeLable];
}

- (void)creatSpecialCellSubviews:(UIImageView *)imageView height:(float)height
{
//    活动主题
    _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 280, 20)];
    
    _titleLable.font = [UIFont systemFontOfSize:15];
    
    [imageView addSubview:_titleLable];
    
    
//    消息内容
    _messageLable = [[STTweetLabel alloc] initWithFrame:CGRectMake(10, 40, 280, height - 80)];
    
    [_messageLable setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0]];
    
    [_messageLable setTextColor:[UIColor blackColor]];
    
    _messageLable.lineBreakMode = NSLineBreakByWordWrapping;
    
    _messageLable.numberOfLines = 0;
    
    [_messageLable setDelegate:self];
    
    [imageView addSubview:_messageLable];
    
    
//    线
    UIImageView *lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_1.png"]];
    
    lineImageView.frame = CGRectMake(10, 40 + (height - 80) + 3, 280, 1);
    
    [imageView addSubview:lineImageView];
    
    
//    日期
    _createDateLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 40 + (height - 80) + 2, 180, 15)];
    
    _createDateLable.textColor = [UIColor redColor];
    
    
    _createDateLable.font = [UIFont systemFontOfSize:13];
    
    [imageView addSubview:_createDateLable];
    
    
//    商家
    _tenantcodeLable = [[UILabel alloc] initWithFrame:CGRectMake(190, 40 + (height - 80) + 2, 100, 15)];
    
    _tenantcodeLable.font = [UIFont systemFontOfSize:14];
    
    [imageView addSubview:_tenantcodeLable];
    
//    线
    UIImageView *line1ImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line_1.png"]];
    
    line1ImageView.frame = CGRectMake(10, 40 + (height - 80) + 17, 280, 1);
    
    [imageView addSubview:line1ImageView];
    
//    可评价消息
    _pingjiaLale = [[UILabel alloc] initWithFrame:CGRectMake(10, 60 + (height - 80) + 2, 100, 15)];
    
    _pingjiaLale.textColor = [UIColor redColor];
    
    _pingjiaLale.text = @"点此消息可评价";
    
    _pingjiaLale.font = [UIFont systemFontOfSize:14];
        
    [imageView addSubview:_pingjiaLale];
}

- (void)imageClick:(NSString *)tag
{
    if ([_cellDelegate respondsToSelector:@selector(backgroundImageClick:)]) {
        [_cellDelegate backgroundImageClick:tag];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
