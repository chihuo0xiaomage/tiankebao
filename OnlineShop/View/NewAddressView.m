//
//  NewAddressView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NewAddressView.h"
#import "AreaView.h"

@implementation NewAddressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame title:(NSString *)title placeholder:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 80, 30)];
        self.label.text = title;
        [self addSubview:self.label];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(_label.frame.origin.x, _label.frame.origin.y + _label.bounds.size.height, 280, 30)];
        self.textField.placeholder = placeholder;
        self.textField.delegate = self;
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.textField];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)];
        self.label.text = title;
        [self addSubview:self.label];
        
        self.provinceView = [[AreaView alloc] initWithFrame:CGRectMake(_label.frame.origin.x + _label.bounds.size.width, _label.frame.origin.y, 90, 40)];
//        self.provinceView.backgroundColor = [UIColor yellowColor];
        [self.provinceView.button setTitle:@"省" forState:UIControlStateNormal];
        [self.provinceView.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.provinceView];
        
        self.cityView = [[AreaView alloc] initWithFrame:CGRectMake(_provinceView.frame.origin.x + _provinceView.bounds.size.width + 25, _provinceView.frame.origin.y, 90, 40)];
        [self.cityView.button setTitle:@"市" forState:UIControlStateNormal];
        [self.cityView.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.cityView];
        
        self.countyView = [[AreaView alloc] initWithFrame:CGRectMake(_provinceView.frame.origin.x, _provinceView.frame.origin.y + _provinceView.bounds.size.height , 160, 40)];
        [self.countyView.button setTitle:@"县" forState:UIControlStateNormal];
        [self.countyView.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.countyView];
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"animation" context:nil];
    if (self.superview.bounds.size.height == 480) {
        if ([textField.placeholder isEqualToString:@"请输入手机号"]) {
            self.superview.frame = CGRectMake(0, -100, 320, self.superview.bounds.size.height);
        }else if ([textField.placeholder isEqualToString:@"您的详细地址"] || [textField.placeholder isEqualToString:@"您要寄往地区的邮编号"])
            self.superview.frame = CGRectMake(0, -200, 320, self.superview.bounds.size.height);
    }else if (self.superview.bounds.size.height == 568){
    if ([textField.placeholder isEqualToString:@"您的详细地址"] || [textField.placeholder isEqualToString:@"您要寄往地区的邮编号"]) {
        self.superview.frame = CGRectMake(0, -110, 320, self.superview.bounds.size.height);
    }
    }
    [UIView commitAnimations];
    return YES;
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
