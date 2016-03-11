//
//  BYCollectionViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYCollectionViewCell.h"
#import "UIImageView+WebCache.h"
@implementation BYCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 140)];
        self.imageView.layer.borderWidth = 0.5;
        self.imageView.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:self.imageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.imageView.frame.origin.x, self.imageView.bounds.size.height, self.imageView.bounds.size.width, 20)];
        self.nameLabel.text = @"男士内衣";
        [self addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.bounds.size.height, self.nameLabel.bounds.size.width, 15)];
        self.nameLabel.font = [UIFont systemFontOfSize:16.0];
        self.priceLabel.text = @"￥199.0";
        self.priceLabel.textColor = [UIColor orangeColor];
        self.priceLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:self.priceLabel];
        self.marketLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.frame.origin.x, self.priceLabel.frame.origin.y + self.priceLabel.bounds.size.height, self.priceLabel.bounds.size.width, 10)];
        self.marketLabel.font = [UIFont systemFontOfSize:12.0];
        self.marketLabel.text = @"￥299  | 已售出34件";
        self.marketLabel.alpha = 0.7;
        [self addSubview:self.marketLabel];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
    }
    [self.imageView setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"image"]] placeholderImage:nil];
    self.nameLabel.text = [_dic objectForKey:@"fullName"];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", [_dic objectForKey:@"price"]];
    NSString * marketPrice = [_dic objectForKey:@"marketPrice"];
    NSString * scoreCount = [_dic objectForKey:@"scoreCount"];
    self.marketLabel.text = [NSString stringWithFormat:@"￥%@  | 已售出%@件", marketPrice, scoreCount];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 0.5);//线条颜色
    CGContextMoveToPoint(context, self.marketLabel.frame.origin.x, self.marketLabel.frame.origin.y + self.marketLabel.bounds.size.height/2);
    CGContextAddLineToPoint(context, 35, self.marketLabel.frame.origin.y + self.marketLabel.bounds.size.height/2);
    CGContextStrokePath(context);
}


@end
