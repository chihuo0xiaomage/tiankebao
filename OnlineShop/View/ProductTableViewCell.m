//
//  ProductTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ProductTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Products.h"
@implementation ProductTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 100, 80)];
        [self addSubview:self.aImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_aImageView.frame.origin.x + _aImageView.bounds.size.width + 10, _aImageView.frame.origin.y, 180, 40)];
        self.nameLabel.font = [UIFont systemFontOfSize:14.0];
        self.nameLabel.numberOfLines = 2;
            //self.nameLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.nameLabel];
        
        self.marketPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.bounds.size.height, 40, 20)];
        self.marketPrice.textAlignment = NSTextAlignmentCenter;
            //self.marketPrice.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.marketPrice];
        
       self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.marketPrice.frame.origin.x, self.marketPrice.frame.origin.y + self.marketPrice.bounds.size.height / 2, self.marketPrice.bounds.size.width, 1.0)];
        _lineImageView.backgroundColor = [UIColor blackColor];
        _lineImageView.alpha = 0.4;
        [self addSubview:_lineImageView];
        self.price = [[UILabel alloc] initWithFrame:CGRectMake(self.marketPrice.frame.origin.x + self.marketPrice.bounds.size.width, self.marketPrice.frame.origin.y, 40, 20)];
        self.price.textColor = [UIColor orangeColor];
        [self addSubview:self.price];
        
        self.scoreCount = [[UILabel alloc] initWithFrame:CGRectMake(self.marketPrice.frame.origin.x, self.marketPrice.frame.origin.y + self.marketPrice.bounds.size.height, 80, 20)];
        self.scoreCount.font = [UIFont systemFontOfSize:12.0];
            //self.scoreCount.backgroundColor = [UIColor yellowColor];
        self.scoreCount.textColor = [UIColor grayColor];
        [self addSubview:self.scoreCount];
        
        self.score = [[UILabel alloc] initWithFrame:CGRectMake(self.scoreCount.frame.origin.x + self.scoreCount.bounds.size.width + 10, self.scoreCount.frame.origin.y, 80, 20)];
        self.score.font = [UIFont systemFontOfSize:12.0];
        self.score.textColor = [UIColor grayColor];
            //self.score.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.score];
    }
    return self;
}
- (void)setProduct:(Products *)product
{
    if (_product != product) {
        _product = product;
    }
    NSString * imageUrl = [self.product.image stringByReplacingOccurrencesOfString:@".jpg" withString:@"-200-160.jpg"];
    [self.aImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    self.nameLabel.text = _product.name;
    CGFloat height = [self heightLableUIFont:[UIFont systemFontOfSize:14.0] sendString:_product.name width:180];
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, self.nameLabel.bounds.size.width, height);
    self.marketPrice.text = [NSString stringWithFormat:@"¥%@.00", _product.marketPrice];
     self.marketPrice.font = [UIFont systemFontOfSize:14.0];
    self.marketPrice.alpha = 0.4;
    CGFloat width = [self widthLableUIFont:[UIFont systemFontOfSize:14.0] sendString:self.marketPrice.text heigh:20];
    self.marketPrice.frame = CGRectMake(self.nameLabel.frame.origin.x, 50, width, 20);
    _lineImageView.frame = CGRectMake(self.marketPrice.frame.origin.x, self.marketPrice.frame.origin.y + self.marketPrice.bounds.size.height / 2, width, 1.0);
    self.price.text = [NSString stringWithFormat:@"¥%.2f", [_product.price floatValue]];
    self.price.frame = CGRectMake(self.marketPrice.frame.origin.x + self.marketPrice.bounds.size.width + 10, self.marketPrice.frame.origin.y, 80, 20);
    
    self.scoreCount.text = [NSString stringWithFormat:@"评论次数:%d", _product.scoreCount];
    self.score.text = [NSString stringWithFormat:@"%.2f分", _product.score];
}
    //缺少封装
- (CGFloat)heightLableUIFont:(UIFont *)font sendString:(NSString *)str width:(NSUInteger)width
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return textRect.size.height;
}
- (CGFloat)widthLableUIFont:(UIFont *)font sendString:(NSString *)str heigh:(NSUInteger)heigh
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(320, heigh) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return textRect.size.width;
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
