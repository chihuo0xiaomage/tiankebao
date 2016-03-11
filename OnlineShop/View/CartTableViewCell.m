//
//  CartTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "CartTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Encrypt.h"
#import "NetWorking.h"
@interface CartTableViewCell ()
{
    BOOL _show;
}
@end

@implementation CartTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changNumberSucceful:) name:@"changShopCartNumber" object:nil];
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 20, 20)];
        self.aImageView.userInteractionEnabled = YES;
        [self addSubview:self.aImageView];
        
        self.shopImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_aImageView.frame.origin.x + _aImageView.bounds.size.width + 5, _aImageView.frame.origin.y - 5, 40, 40)];
        [self addSubview:self.shopImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopImageView.frame.origin.x + _shopImageView.bounds.size.width + 5, _shopImageView.frame.origin.y, 200, 20)];
        [self addSubview:self.nameLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, 200, 20)];
            //self.priceLabel.text = @"单价:";
        [self addSubview:self.priceLabel];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(_shopImageView.frame.origin.x ,_shopImageView.frame.origin.y + _shopImageView.bounds.size.height + 5, 40, 20)];
            //self.countLabel.text = @"数量:";
        [self addSubview:self.countLabel];
        
        self.decrementButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.decrementButton.frame = CGRectMake(_countLabel.frame.origin.x + _countLabel.bounds.size.width, _countLabel.frame.origin.y, 30, 20);
        
        [self.decrementButton setTitle:@"-" forState:UIControlStateNormal];
        [self.decrementButton addTarget:self action:@selector(changeShopNumber:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.decrementButton];
        
        self.number = [[UILabel alloc] initWithFrame:CGRectMake(_decrementButton.frame.origin.x + _decrementButton.bounds.size.width, _decrementButton.frame.origin.y, 40, 20)];

        self.number.textAlignment = NSTextAlignmentCenter;
        self.number.layer.cornerRadius = 5.0;
        self.number.clipsToBounds = YES;
        self.number.layer.borderWidth = 0.5;
        self.number.layer.borderColor = [UIColor grayColor].CGColor;
        [self addSubview:self.number];
        
        self.addButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.addButton.frame = CGRectMake(_number.frame.origin.x + _number.bounds.size.width, _number.frame.origin.y, 30, 20);
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton addTarget:self action:@selector(changeShopNumber:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];
        
        self.totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(_addButton.frame.origin.x + _addButton.bounds.size.width, _addButton.frame.origin.y, 120, 20)];
        self.totalPriceLabel.text = @"小计:";
        [self addSubview:_totalPriceLabel];
    }
    return self;
}
- (void)setByShopCartDic:(NSDictionary *)byShopCartDic
{
    if (_byShopCartDic != byShopCartDic) {
        _byShopCartDic = byShopCartDic;
    }
    NSString * image = [_byShopCartDic objectForKey:@"image"];
    [self.shopImageView setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil];
    self.nameLabel.text = [_byShopCartDic objectForKey:@"name"];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@", [_byShopCartDic objectForKey:@"price"]];
    self.priceLabel.textColor = [UIColor orangeColor];
    self.number.text = [NSString stringWithFormat:@"%@", [_byShopCartDic objectForKey:@"quantity"]];
    float sum = [[_byShopCartDic objectForKey:@"price"] floatValue] * [[_byShopCartDic objectForKey:@"quantity"] floatValue];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"小计:￥%.2f", sum];
}
- (void)changeShopNumber:(UIButton *)sender
{
    int number = [self.number.text integerValue];
    if (sender == self.decrementButton && number > 0) {
        [self changShopCartNumber:--number];
    }
    if (sender == self.addButton) {
        [self changShopCartNumber:++number];
    }
}
- (void)changShopCartNumber:(int)number
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.cart.item.mod&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&cartItemId=%@&quantity=%d", time, [_byShopCartDic objectForKey:@"cid"], number];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:@"changShopCartNumber"];
}
- (void)changNumberSucceful:(NSNotification *)notification
{
    NSData * data = [notification object];
    if ([[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"resultCode"] intValue] == 0){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMain" object:nil userInfo:nil];
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
