//
//  ProductTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Products;
@interface ProductTableViewCell : UITableViewCell

@property(nonatomic, strong)Products * product;
@property(nonatomic, strong)UIImageView * aImageView;
@property(nonatomic, strong)UIImageView * lineImageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * marketPrice;
@property(nonatomic, strong)UILabel * price;
@property(nonatomic, strong)UILabel * scoreCount;
@property(nonatomic, strong)UILabel * score;
@end
