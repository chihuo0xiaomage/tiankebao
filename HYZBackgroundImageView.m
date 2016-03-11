//
//  HYZBackgroundImageView.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZBackgroundImageView.h"

#import "HYZUITapGestureRecognizer+Tag.h"

@implementation HYZBackgroundImageView

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image tag:(NSString *)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = image;
        
        CGFloat top = 30; // 顶端盖高度
        
        CGFloat bottom = 10; // 底端盖高度
        
        CGFloat left = 100; // 左端盖宽度
        
        CGFloat right = 100; // 右端盖宽度
        
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        
        self.image = [self.image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundImageClicked:)];
        
        click.tag = tag;
        
        [self addGestureRecognizer:click];
    }
    return self;
}

- (void)backgroundImageClicked:(UITapGestureRecognizer *)sender
{
    if ([_delegate respondsToSelector:@selector(imageClick:)]) {
        [_delegate imageClick:sender.tag];
    }
}

@end
