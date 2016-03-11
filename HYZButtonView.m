//
//  HYZButtonView.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZButtonView.h"

@implementation HYZButtonView

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)labeltext
{
    self = [super initWithFrame:frame];
    if (self) {
//        调用创建背景图片的方法并把子imageView的名字和label的标题都传过去
        [self creatMyButtonBackgroundImageName:imageName title:labeltext];
    }
    return self;
}

//创建一个背景图并设置能够接受点击事件
- (void)creatMyButtonBackgroundImageName:(NSString *)imageName title:(NSString *)labeltext
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    
    backgroundImageView.backgroundColor = [UIColor whiteColor];
    
    backgroundImageView.userInteractionEnabled = YES;
    
    [self addSubview:backgroundImageView];
    
//    调用创建子视图的方法并将子视图的图片名字和label的标题传过去
    [self creatSmallImageViewAndLable:backgroundImageView imageName:imageName title:labeltext];
    
//    为imageView增加点击方法
    UITapGestureRecognizer * click=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
    
    click.tag = labeltext;
    
    [backgroundImageView addGestureRecognizer:click];
    
}


- (void)creatSmallImageViewAndLable:(UIImageView *)imageView imageName:(NSString *)imageName title:(NSString *)labeltext
{
    UIImageView *smallImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    
    smallImageView.image = [UIImage imageNamed:imageName];
    
    smallImageView.userInteractionEnabled = NO;
    
    [imageView addSubview:smallImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 80, 20)];
    
    titleLabel.text = labeltext;
    
    titleLabel.textColor = [UIColor redColor];
    
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [imageView addSubview:titleLabel];
}

- (void)imageViewClicked:(UITapGestureRecognizer *)UITapGestureRecognizer
{
    if ([_delegate respondsToSelector:@selector(imageViewClicked:)]) {
        [_delegate imageViewClicked:UITapGestureRecognizer.tag];
    }
}

@end
