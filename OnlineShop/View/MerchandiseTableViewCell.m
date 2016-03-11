//
//  MerchandiseTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MerchandiseTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MerchandiseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 60)];
//        self.aImageView.backgroundColor = [UIColor yellowColor];
//        [self addSubview:self.aImageView];
//        
//        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_aImageView.frame.origin.x + _aImageView.bounds.size.width + 10, _aImageView.frame.origin.y + 5, 180, 40)];
//        self.nameLabel.numberOfLines = 0;
//        [self addSubview:self.nameLabel];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 180, 60)];
        self.nameLabel.font = [UIFont systemFontOfSize:20.0];
            //设置字体样式
            //[UIFont fontWithName:<#(NSString *)#> size:<#(CGFloat)#>]
            //默认大小写粗体子
            //self.nameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [self addSubview:self.nameLabel];
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
    }
    NSString * strUrl = [[_dic objectForKey:@"image"] stringByReplacingOccurrencesOfString:@".jpg" withString:@"-120-120.jpg"];
    [self.aImageView setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:nil];
    self.nameLabel.text = [_dic objectForKey:@"name"];
    CGFloat height = [self heightLableUIFont:[UIFont systemFontOfSize:17.0] sendString:[_dic objectForKey:@"name"] width:180];
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, self.nameLabel.bounds.size.width, height);
}
- (CGFloat)heightLableUIFont:(UIFont *)font sendString:(NSString *)str width:(NSUInteger)width
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return textRect.size.height;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
