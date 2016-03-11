//
//  BYCollectionViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong)NSDictionary * dic;
@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * priceLabel;
@property(nonatomic, strong)UILabel * marketLabel;
@end
