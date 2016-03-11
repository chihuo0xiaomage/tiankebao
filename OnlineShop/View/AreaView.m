//
//  AreaView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "AreaView.h"

@implementation AreaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 30, 30)];
        self.areaLabel.backgroundColor = [UIColor whiteColor];
        self.areaLabel.layer.cornerRadius = 4.0;
        self.areaLabel.clipsToBounds = YES;
        [self addSubview:self.areaLabel];
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.layer.cornerRadius = 4.0;
        self.button.backgroundColor = [UIColor whiteColor];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.button.frame = CGRectMake(self.areaLabel.frame.origin.x + self.areaLabel.bounds.size.width - 5, self.areaLabel.frame.origin.y, 35, 30);
        [self addSubview:self.button];
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
