//
//  LoginView.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)UITextField * textField;
@property(nonatomic, strong)UIButton * login;
@property(nonatomic, strong)UILabel * label;
@property(nonatomic, strong)UILabel * registerLabel;
@property(nonatomic, strong)UILabel * findPassWord;

- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action image:(UIImage *)image;
@end
