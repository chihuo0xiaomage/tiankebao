//
//  SecondView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SecondView.h"

@implementation SecondView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 145, 100)];
//        self.imageView.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.imageView];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
            //self.nameLabel.backgroundColor = [UIColor greenColor];
        self.nameLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:self.nameLabel];
        
        self.originalPrice = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.bounds.size.height, 60, 20)];
        self.originalPrice.textColor = [UIColor orangeColor];
            //self.originalPrice.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.originalPrice];
        
        self.grabLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.originalPrice.frame.origin.x, self.originalPrice.frame.origin.y + self.originalPrice.bounds.size.height, 60, 20)];
        self.grabLabel.font = [UIFont systemFontOfSize:10.0];
            //self.grabLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:self.grabLabel];
        
       
//
//        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.bounds.size.width, _imageView.frame.origin.y, 160, 20)];
//        self.nameLabel.text = @"纯情皮鞋子";
//        self.nameLabel.font = [UIFont systemFontOfSize:16.0];
//        self.nameLabel.alpha = 0.6;
//        [self addSubview:self.nameLabel];
//        
//        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height, 160, 20)];
//        self.timeLabel.text = @"剩余时间:00:00";
//        [self addSubview:self.timeLabel];
//        
//        self.grabLabel = [[UILabel alloc] initWithFrame:CGRectMake(_timeLabel.frame.origin.x, _timeLabel.frame.origin.y + _timeLabel.bounds.size.height, 160, 20)];
//        self.grabLabel.alpha = 0.6;
//        self.grabLabel.font = [UIFont systemFontOfSize:14.0];
//        self.grabLabel.text = @"抢购价:499";
//        [self addSubview:self.grabLabel];
//        
//        self.originalPrice = [[UILabel alloc] initWithFrame:CGRectMake(_grabLabel.frame.origin.x, _grabLabel.frame.origin.y + _grabLabel.bounds.size.height, 160, 20)];
//        self.originalPrice.font = [UIFont systemFontOfSize:14.0];
//        self.originalPrice.alpha = 0.6;
//        self.originalPrice.text = @"原价:999";
//        [self addSubview:self.originalPrice];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
