//
//  CartTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

    //@class BYShopCartViewController;
@interface CartTableViewCell : UITableViewCell
@property(nonatomic, strong)UIImageView * aImageView;
@property(nonatomic, strong)UIImageView * shopImageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * priceLabel;
@property(nonatomic, strong)UILabel * countLabel;
@property(nonatomic, strong)UIButton * decrementButton;
@property(nonatomic, strong)UIButton * addButton;
@property(nonatomic, strong)UILabel * number;
@property(nonatomic, strong)UILabel * totalPriceLabel;

@property(nonatomic, strong)NSDictionary * byShopCartDic;
@end
