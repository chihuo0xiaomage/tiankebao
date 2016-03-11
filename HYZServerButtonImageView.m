//
//  HYZServerButtonImageView.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZServerButtonImageView.h"

@implementation HYZServerButtonImageView

- (id)initWithFrame:(CGRect)frame smallImageName:(NSString *)string titleText:(NSString *)titleString
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
//    为imageView增加点击方法
        UITapGestureRecognizer * click=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
        
        click.tag = titleString;
        
        [self addGestureRecognizer:click];
        
        [self addSmallImageViewAndLableSmallImageName:string titleText:titleString];
    }
    return self;
}

- (void)addSmallImageViewAndLableSmallImageName:(NSString *)string titleText:(NSString *)titleString
{
    UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 66, 66)];
    
    smallImageView.image = [UIImage imageNamed:string];
    
    smallImageView.userInteractionEnabled = NO;
    
    [self addSubview:smallImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 76, 106, 30)];
    
    titleLabel.text = titleString;
    
    titleLabel.textColor = [UIColor redColor];
    
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:titleLabel];
}

- (void)imageViewClicked:(UITapGestureRecognizer *)UITapGestureRecognizer
{
    if ([_delegate respondsToSelector:@selector(imageButtonClicked:)]) {
        [_delegate imageButtonClicked:UITapGestureRecognizer.tag];
    }
}

@end
