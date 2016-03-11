//
//  LoginView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LoginView.h"

@interface LoginView ()
{
    id _target;
    SEL _action;
}
@end

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        _target = target;
        _action = action;
        
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.frame = CGRectMake(0, 0, 40, 40);
//        self.imageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(self.imageView.frame.origin.x + self.imageView.bounds.size.width, self.imageView.frame.origin.y, 240, 40)];
        self.textField.autocapitalizationType =  UITextAutocapitalizationTypeNone;
        self.textField.borderStyle = UITextBorderStyleBezel;
        [self addSubview:self.textField];
        
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
