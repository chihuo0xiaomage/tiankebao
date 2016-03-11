//
//  MyOrderTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-11-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface MyOrderTableViewCell ()
@property(nonatomic, strong)UIImageView * aImageView;
@property(nonatomic, strong)UILabel     * nameLabel;
@property(nonatomic, strong)UILabel     * priceLabel;
@property(nonatomic, strong)UILabel     * numberLabel;
@end

@implementation MyOrderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        [self addSubview:self.aImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_aImageView.frame.origin.x + _aImageView.bounds.size.width + 5, _aImageView.frame.origin.y, 240, 20)];
        [self addSubview:self.nameLabel];
        
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y + self.nameLabel.bounds.size.height + 5, 70, 20)];
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_numberLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_numberLabel.frame.origin.x + _numberLabel.bounds.size.width + 5, _numberLabel.frame.origin.y, 140, 20)];
        self.priceLabel.textColor = [UIColor orangeColor];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
    }
    [_aImageView setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"image"]] placeholderImage:nil];
    _nameLabel.text = [_dic objectForKey:@"name"];
    _numberLabel.text =[NSString stringWithFormat:@"数量:%d", [[_dic objectForKey:@"quantity"] intValue]];
    _priceLabel.text = [NSString stringWithFormat:@"合计:￥%.2f", [[_dic objectForKey:@"price"] floatValue]];
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
