//
//  BYHeadView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYHeadView.h"

@interface BYHeadView ()
{
    BOOL _start;
    UILabel * _startLabel;
}
@end

@implementation BYHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _start = YES;
        self.layer.borderWidth = 1.0;
        self.backgroundColor = BACKGROUND_COLOR;
        self.layer.borderColor = BACKGROUND_COLOR.CGColor;
        
        self.promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
        self.promptLabel.alpha = 0.7;
            // self.promptLabel.backgroundColor = [UIColor greenColor];
        self.promptLabel.text = @"抢购中";
        self.promptLabel.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:self.promptLabel];
        
        self.startLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.promptLabel.frame.origin.x + self.promptLabel.bounds.size.width + 30, self.promptLabel.frame.origin.y, 100, 20)];
            //self.startLabel.backgroundColor = [UIColor redColor];
        self.startLabel.font = [UIFont systemFontOfSize:15.0];
        self.startLabel.alpha = 0.6;
        self.startLabel.text = @"距离本场结束";
        [self addSubview:self.startLabel];
        
        self.HLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.startLabel.frame.origin.x + self.startLabel.bounds.size.width, self.startLabel.frame.origin.y, 25, 20)];
        self.HLabel.text = @"00";
        self.HLabel.backgroundColor = [UIColor yellowColor];
        self.HLabel.backgroundColor = [UIColor grayColor];
        self.HLabel.textColor = [UIColor whiteColor];
        self.HLabel.layer.cornerRadius = 3.0;
        self.HLabel.textAlignment = NSTextAlignmentCenter;
        self.HLabel.clipsToBounds = YES;
        [self addSubview:self.HLabel];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.HLabel.frame.origin.x + self.HLabel.bounds.size.width, self.HLabel.frame.origin.y, 20, 20)];
        self.label.text = @":";
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        self.MLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.label.frame.origin.x + self.label.bounds.size.width, self.label.frame.origin.y, 25, 20)];
        self.MLabel.backgroundColor = [UIColor grayColor];
        self.MLabel.text = @"00";
        self.MLabel.layer.cornerRadius = 3.0;
        self.MLabel.textColor = [UIColor whiteColor];
        self.MLabel.clipsToBounds = YES;
        self.MLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.MLabel];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(self.MLabel.frame.origin.x + self.MLabel.bounds.size.width, self.MLabel.frame.origin.y, 20, 20)];
        self.label.text = @":";
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        
        self.SLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.label.frame.origin.x + self.label.bounds.size.width, self.label.frame.origin.y, 25, 20)];
        self.SLabel.backgroundColor = [UIColor grayColor];
        self.SLabel.text = @"00";
        self.SLabel.layer.cornerRadius = 3.0;
        self.SLabel.textColor = [UIColor whiteColor];
        self.SLabel.clipsToBounds = YES;
        self.SLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.SLabel];
        _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _startLabel.text = @"抢购未开始";
        _startLabel.textAlignment = NSTextAlignmentCenter;
        _startLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_startLabel];
    }
    return self;
}
- (void)setDic:(NSDictionary *)dic
{
    if (_dic != dic) {
        _dic = dic;
    }
    self.begin = NO;
    if ([[_dic objectForKey:@"startTime"] isEqualToString:[_dic objectForKey:@"systemDate"]]) {
        _startLabel.hidden = YES;
        self.begin = YES;
    NSArray * array = [[_dic objectForKey:@"startTime"] componentsSeparatedByString:@" "];
    NSArray * timeArray = [[array lastObject] componentsSeparatedByString:@":"];
    _HLabel.text = [timeArray firstObject];
    _MLabel.text = [timeArray objectAtIndex:1];
    _SLabel.text = [timeArray lastObject];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setTime) userInfo:nil repeats:YES];
    }
}
- (void)setTime
{
    int s = [_SLabel.text intValue];
    int m = [_MLabel.text intValue];
    int h = [_HLabel.text intValue];
    if (s == 0 && m == 0 && h == 0) {
        [_timer invalidate];
        _startLabel.hidden = NO;
        _startLabel.text = @"抢购结束";
        self.begin = NO;
    }
    if (_start) {
        if (s == 0 && m == 0) {
        _SLabel.text = @"60";
        _MLabel.text = @"59";
            }
    }
    
    if (s > 0) {
        if (s > 10) {
             _SLabel.text = [NSString stringWithFormat:@"%d", --s];
        }else{
            _SLabel.text = [NSString stringWithFormat:@"0%d", --s];
        }
    }
    if (s == 0 && m > 0) {
        _MLabel.text = [NSString stringWithFormat:@"%d", --m];
        _SLabel.text = @"60";
    }
    if (m == 0 && h > 0) {
        _HLabel.text = [NSString stringWithFormat:@"%d", --h];
        _MLabel.text = @"60";
    }
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
