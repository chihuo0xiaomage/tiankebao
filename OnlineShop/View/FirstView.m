//
//  FirstView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "FirstView.h"
#define BACKGROUND_COLOR [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]
@implementation FirstView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame title:(NSString *)title info:(NSString *)info
{
    self = [super initWithFrame:frame];
    if (self) {
            //self.backgroundColor = [UIColor yellowColor];
//        self.layer.cornerRadius = 4.0;
//        self.backgroundColor = [UIColor whiteColor];
//        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 14)];
//        self.titleLabel.alpha = 0.8;
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.titleLabel.text = title;
//        self.titleLabel.font = [UIFont systemFontOfSize:14.0];
//        self.titleLabel.backgroundColor = [UIColor redColor];
//        self.titleLabel.layer.cornerRadius =  4.0;
//        self.titleLabel.clipsToBounds = YES;
//        [self addSubview:self.titleLabel];
//        
//        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _titleLabel.bounds.size.height, 90, 14)];
//        self.infoLabel.font = [UIFont systemFontOfSize:10.0];
//        self.infoLabel.textColor = [UIColor blackColor];
//        self.infoLabel.alpha = 0.6;
//        self.infoLabel.text = info;
//        self.infoLabel.textAlignment = NSTextAlignmentCenter;
//        self.infoLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:_infoLabel];
        
//        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_infoLabel.frame.origin.x + 5, _infoLabel.frame.origin.y + _infoLabel.bounds.size.height, 60, 40)];
//        self.imageView.layer.cornerRadius = 4.0;
            //self.imageView.backgroundColor = [UIColor greenColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame title:(NSString *)title UIImage:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 20)];
        self.titleLabel.alpha = 0.8;
//        self.titleLabel.backgroundColor = [UIColor yellowColor];
        self.titleLabel.text = title;
        [self addSubview:self.titleLabel];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 40, 20, 40, 40)];
//        self.imageView.backgroundColor = [UIColor redColor];
        self.imageView.image = image;
        [self addSubview:self.imageView];
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
