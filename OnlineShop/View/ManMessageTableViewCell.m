//
//  ManMessageTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ManMessageTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation ManMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
            //self.aImageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_aImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_aImageView.frame.origin.x + _aImageView.bounds.size.width + 5, _aImageView.frame.origin.y, 240, 25)];
            //self.nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_nameLabel];
    
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, 140, 25)];
//        self.priceLabel.font = [UIFont systemFontOfSize:14.0];
            //self.priceLabel.backgroundColor = [UIColor yellowColor];
            //self.priceLabel.text = @"单价:13000";
        [self addSubview:_priceLabel];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_priceLabel.frame.origin.x + _priceLabel.bounds.size.width, _priceLabel.frame.origin.y, 100, 25)];
            //self.numberLabel.text = @"数量:10";
            //self.numberLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_numberLabel];
    }
    return self;
}
- (void)setManMessageDic:(NSDictionary *)manMessageDic
{
    if (_manMessageDic != manMessageDic) {
        _manMessageDic = manMessageDic;
    }
    NSString * imageUrl = [_manMessageDic objectForKey:@"image"];
    [self.aImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", [_manMessageDic objectForKey:@"name"]];

    self.priceLabel.text = [NSString stringWithFormat:@"价格:￥%.2f", [[_manMessageDic objectForKey:@"price"] floatValue]];
    self.priceLabel.textColor = [UIColor orangeColor];
    NSArray * array = [_manMessageDic allKeys];
    if ([array containsObject:@"quantity"]) {
        self.numberLabel.text = [NSString stringWithFormat:@"数量:%@", [_manMessageDic objectForKey:@"quantity"]];
    }else {
        self.numberLabel.text = @"数量:1";
    }
    
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
