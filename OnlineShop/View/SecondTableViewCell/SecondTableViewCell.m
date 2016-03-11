//
//  SecondTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "FirstView.h"
#define BACKGROUND_COLOR [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]
@implementation SecondTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = BACKGROUND_COLOR;
        self.firstView = [[FirstView alloc] initWithFrame:CGRectMake(10, 10, 90, 68) title:@"精品推荐" info:@"疯抢9.9元专供精品"];
        self.firstView.identifier = 1;
        self.firstView.imageView.image = [UIImage imageNamed:@"jinpin@2x.png"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.firstView addGestureRecognizer:tap];
        [self addSubview:_firstView];
        
        self.secondView = [[FirstView alloc] initWithFrame:CGRectMake(_firstView.bounds.size.width + 15 + _firstView.frame.origin.x, _firstView.frame.origin.y, 90, 68) title:@"新品首发" info:@"超值新品首发"];
        self.secondView.identifier = 2;
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.secondView addGestureRecognizer:tap1];
        self.secondView.imageView.image = [UIImage imageNamed:@"xinpin@2x.png"];
        [self addSubview:_secondView];
       
        self.thirdView = [[FirstView alloc] initWithFrame:CGRectMake(_secondView.frame.origin.x + _secondView.bounds.size.width + 15, _secondView.frame.origin.y, 90, 68) title:@"抱团抢购" info:@"越团购越实惠"];
        self.thirdView.imageView.image = [UIImage imageNamed:@"tuangou@2x.png"];
        self.thirdView.identifier = 3;
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.thirdView addGestureRecognizer:tap2];
        [self addSubview:_thirdView];
    }
    return self;
}
- (void)tap:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BYRECOMMEND" object:[NSNumber numberWithInteger:((FirstView *)tap.view).identifier]];
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
