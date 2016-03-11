//
//  HYZCarButtonImageView.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCarButtonImageView.h"

@implementation HYZCarButtonImageView

@synthesize backgroundImageView = _backgroundImageView;

- (id)initWithFrame:(CGRect)frame buttonTag:(NSString *)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 2, 25, 26)];
        
        [self addSubview:_backgroundImageView];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        
        click.tag = tag;
        
        [self addGestureRecognizer:click];
    }
    return self;
}

- (void)imageViewClick:(UITapGestureRecognizer *)UITapGestureRecognizer
{
    if ([_delegate respondsToSelector:@selector(imageViewButtonClicked:)]) {
        [_delegate imageViewButtonClicked:UITapGestureRecognizer];
    }
}

@end
