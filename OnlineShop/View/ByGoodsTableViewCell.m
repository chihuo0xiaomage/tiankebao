//
//  ByGoodsTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ByGoodsTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ByGoodsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
            //self.aImageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.aImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.aImageView.frame.origin.x + self.aImageView.bounds.size.width + 5, self.aImageView.frame.origin.y, 200, 20)];
        self.nameLabel.numberOfLines = 0;
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.nameLabel];
        
        self.secKillLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.bounds.size.height + 30, 160, 20)];
        self.secKillLabel.textColor = [UIColor orangeColor];
        self.secKillLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:self.secKillLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.secKillLabel.frame.origin.x, self.secKillLabel.frame.origin.y + self.secKillLabel.bounds.size.height + 5, 160, 15)];
        self.priceLabel.font = [UIFont systemFontOfSize:10.0];
        self.priceLabel.alpha = 0.6;
        [self addSubview:self.priceLabel];
        
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
    }
    [self.aImageView setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"image"]] placeholderImage:nil];
    CGFloat height = [self heightLableUIFont:[UIFont systemFontOfSize:12.0] sendString:[_dic objectForKey:@"goodsName"] width:self.nameLabel.bounds.size.width];
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, self.nameLabel.bounds.size.width, height);
    self.nameLabel.text = [NSString stringWithFormat:@"%@", [_dic objectForKey:@"goodsName"]];
    
    CGFloat killWidth = [self widthLableUIFont:[UIFont systemFontOfSize:14.0] sendString:[NSString stringWithFormat:@"￥%@", [_dic objectForKey:@"ypice"]] height:self.secKillLabel.bounds.size.height];
    self.secKillLabel.frame = CGRectMake(self.secKillLabel.frame.origin.x, self.secKillLabel.frame.origin.y, killWidth, self.secKillLabel.bounds.size.height);
    self.secKillLabel.text = [NSString stringWithFormat:@"￥%@", [_dic objectForKey:@"ypice"]];
    CGFloat priceWidth = [self widthLableUIFont:[UIFont systemFontOfSize:10.0] sendString:[NSString stringWithFormat:@"￥%@", [_dic objectForKey:@"price"] ] height:self.priceLabel.bounds.size.height];
    self.priceLabel.frame = CGRectMake(self.priceLabel.frame.origin.x, self.priceLabel.frame.origin.y, priceWidth, self.priceLabel.bounds.size.height);
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", [_dic objectForKey:@"price"]];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(self.priceLabel.frame.origin.x, self.priceLabel.frame.origin.y + self.priceLabel.bounds.size.height/2, self.priceLabel.bounds.size.width, 0.50)];
    view.backgroundColor = [UIColor grayColor];
    view.alpha = 0.6;
    [self addSubview:view];
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
- (CGFloat)widthLableUIFont:(UIFont *)font sendString:(NSString *)str height:(NSUInteger)height
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(310, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return textRect.size.width;
}
- (CGFloat)heightLableUIFont:(UIFont *)font sendString:(NSString *)str width:(NSUInteger)width
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return textRect.size.height;
}
@end
