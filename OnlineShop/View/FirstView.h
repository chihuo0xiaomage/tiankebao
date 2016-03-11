//
//  FirstView.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstView : UIView

@property(nonatomic, strong)UILabel * titleLabel;
@property(nonatomic, strong)UILabel * infoLabel;
@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, assign)NSUInteger identifier;

    //第一种view
- (id)initWithFrame:(CGRect)frame title:(NSString *)title info:(NSString *)info;
    //第二种View
- (id)initWithFrame:(CGRect)frame title:(NSString *)title UIImage:(UIImage *)image;
@end
