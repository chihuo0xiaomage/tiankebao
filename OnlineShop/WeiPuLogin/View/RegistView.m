//
//  RegistView.m
//  WeiPeng
//
//  Created by 宝源科技 on 15/11/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RegistView.h"
@interface RegistView ()
{
    id _target;
    SEL _action;
}
@end
@implementation RegistView
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
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
