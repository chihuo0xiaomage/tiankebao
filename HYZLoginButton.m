//
//  HYZLoginButton.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZLoginButton.h"

#define FRAME_HEIGHT    self.bounds.size.height

#define FRAME_WIDTH     self.bounds.size.width

@implementation HYZLoginButton

- (id)initWithFrame:(CGRect)frame leftImage:(NSString *)imageNameString title:(NSString *)titleString
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FRAME_HEIGHT, FRAME_HEIGHT)];
        
        leftImageView.image = [UIImage imageNamed:imageNameString];
        
        [self addSubview:leftImageView];
        
        
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(FRAME_HEIGHT, 0, FRAME_WIDTH - FRAME_HEIGHT, FRAME_HEIGHT)];
        
        titleLable.backgroundColor = [UIColor clearColor];
        
        titleLable.text = titleString;
        
        [self addSubview:titleLable];
        
//    为View增加点击方法
//        UITapGestureRecognizer * click=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
//        
//        click.tag = titleString;
//        
//        [self addGestureRecognizer:click];
        
    }
    return self;
}

//- (void)imageViewClicked:(UITapGestureRecognizer *)UITapGestureRecognizer
//{
//    if ([UITapGestureRecognizer.tag isEqualToString:@"qq登录"]) {
//        if ([_delegate respondsToSelector:@selector(HYZQQLoginButtonClicked)]) {
//            [_delegate HYZQQLoginButtonClicked];
//        }
//    }
//    else{
//        if ([_delegate respondsToSelector:@selector(HYZSinaLoginButtonClicked)]) {
//            [_delegate HYZSinaLoginButtonClicked];
//        };
//    }
//    
//}
//
@end
