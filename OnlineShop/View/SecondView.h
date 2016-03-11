//
//  SecondView.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-25.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondView : UIView
@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * timeLabel;
@property(nonatomic, strong)UILabel * grabLabel;
@property(nonatomic, strong)UILabel * originalPrice;
@property(nonatomic, assign)NSString * ident;
@end
