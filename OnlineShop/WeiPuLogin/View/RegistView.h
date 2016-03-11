//
//  RegistView.h
//  WeiPeng
//
//  Created by 宝源科技 on 15/11/2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistView : UIView
@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)UITextField * textField;
@property(nonatomic, strong)UIButton * regist;
@property(nonatomic, strong)UILabel * label;


- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action image:(UIImage *)image;

@end
