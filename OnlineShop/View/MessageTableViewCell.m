//
//  MessageTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addControl];
    }
    return self;
}
- (void)addControl
{
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
        //self.nameLabel.backgroundColor = [UIColor  redColor];
    self.nameLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:self.nameLabel];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x + _nameLabel.bounds.size.width, _nameLabel.frame.origin.y, 120, 40)];
        //self.phoneLabel.backgroundColor = [UIColor yellowColor];
    self.phoneLabel.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:self.phoneLabel];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, 220, 40)];
        //self.addressLabel.backgroundColor = [UIColor redColor];
    self.addressLabel.numberOfLines = 2;
    self.addressLabel.font = [UIFont systemFontOfSize:14.0];
    self.addressLabel.numberOfLines = 0;
    [self addSubview:self.addressLabel];
    
    UIImageView * aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.phoneLabel.frame.origin.x + self.phoneLabel.bounds.size.width + 10, self.phoneLabel.frame.origin.y, 80, 80)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAddress)];
    aImageView.userInteractionEnabled = YES;
    [aImageView addGestureRecognizer:tap];
    aImageView.backgroundColor = BACKGROUND_COLOR;
    [self addSubview:aImageView];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(aImageView.frame.origin.x + 25, aImageView.frame.origin.y + 10, 30, 60)];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.textColor = [UIColor orangeColor];
    label.text = @"修改";
    label.font = [UIFont systemFontOfSize:22.0];
    
//    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
}
- (void)changeAddress
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeAddress" object:_messageDic];
}
- (void)setMessageDic:(NSDictionary *)messageDic
{
    if (_messageDic != messageDic) {
        _messageDic = messageDic;
    }
    self.nameLabel.text = [[NSString stringWithFormat:@"姓名:%@", [_messageDic objectForKey:@"name"]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.phoneLabel.text = [NSString stringWithFormat:@"电话:%@", [_messageDic objectForKey:@"phone"]];
    self.addressLabel.text = [NSString stringWithFormat:@"地址:%@%@", [_messageDic objectForKey:@"areaName"], [[_messageDic objectForKey:@"address"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
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
