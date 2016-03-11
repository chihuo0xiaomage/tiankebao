//
//  ByGoodsTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ByGoodsTableViewCell : UITableViewCell

@property(nonatomic, strong)NSDictionary * dic;
@property(nonatomic, strong)UIImageView * aImageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * priceLabel;
@property(nonatomic, strong)UILabel * secKillLabel;
@end
