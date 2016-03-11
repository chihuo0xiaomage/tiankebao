//
//  HYZHistoryCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-2.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYZHistoryCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier image:(UIImage *)image;

@property (nonatomic, strong) UILabel         *cardNoLable;

@property (nonatomic, strong) UILabel         *dcardMoneyLable;

@property (nonatomic, strong) UILabel         *ddateLable;

@property (nonatomic, strong) UILabel         *dshopnameLable;

- (void)creatSubviews;

@end
