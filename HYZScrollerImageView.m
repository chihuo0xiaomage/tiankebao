//
//  HYZScrollerImageView.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZScrollerImageView.h"

#import "HYZUITapGestureRecognizer+Tag.h"

@implementation HYZScrollerImageView

- (id)initWithFrame:(CGRect)frame imageViewTag:(NSString *)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        [self touchUpInsideimageViewTag:tag];
    }
    return self;
}

- (void)touchUpInsideimageViewTag:(NSString *)tag
{
//    为imageView增加点击方法
    UITapGestureRecognizer * click=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
    
    click.tag = tag;
    
    [self addGestureRecognizer:click];
}

- (void)imageViewClicked:(UITapGestureRecognizer *)UITapGestureRecognizer
{
    if ([_delegate respondsToSelector:@selector(imageTouched:)])
    {
        [_delegate imageTouched:UITapGestureRecognizer.tag];
    }
}

@end
