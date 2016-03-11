//
//  HYZCardTransactionScrollView.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZCardTransactionScrollView.h"

@implementation HYZCardTransactionScrollView

- (id)initWithFrame:(CGRect)frame imageNameArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addScrollViewSubview:self imageNameArray:array];
    }
    return self;
}

- (void)addScrollViewSubview:(UIView *)view imageNameArray:(NSArray *)array
{
    for (int i = 0; i < [array count]; i ++)
    {
        HYZScrollerImageView *scrollImageView = [[HYZScrollerImageView alloc] initWithFrame:CGRectMake(i * 320, 0, self.bounds.size.width, self.bounds.size.height) imageViewTag:[NSString stringWithFormat:@"%d",i]];
        
        scrollImageView.image = [UIImage imageNamed:[array objectAtIndex:i]];
        
        scrollImageView.userInteractionEnabled = YES;
        
        scrollImageView.delegate =self;
        
        [self addSubview:scrollImageView];
    }
    
}

- (void)imageTouched:(NSString *)tag
{
    if ([_scrollDelegate respondsToSelector:@selector(imageTouchUpInside:)])
    {
        [_scrollDelegate imageTouchUpInside:tag];
    }
}

@end
