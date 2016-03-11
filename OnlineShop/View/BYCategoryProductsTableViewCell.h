//
//  BYCategoryProductsTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BYCatelogs;
@interface BYCategoryProductsTableViewCell : UITableViewCell

@property(nonatomic, strong)UIImageView * aImageView;
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)BYCatelogs * byCatelogs;
@end
