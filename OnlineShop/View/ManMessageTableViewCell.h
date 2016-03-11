//
//  ManMessageTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManMessageTableViewCell : UITableViewCell
@property(nonatomic, strong)UIImageView * aImageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel *priceLabel;
@property(nonatomic, strong)UILabel * numberLabel;
@property(nonatomic, strong)NSDictionary * manMessageDic;
@end
