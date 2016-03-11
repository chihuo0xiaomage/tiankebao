//
//  HYZPromotionDetailCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYZPromotionDetailCellDelegate <NSObject>

- (void)share:(UIButton *)sender;

@end

@interface HYZPromotionDetailCell : UITableViewCell

@property (nonatomic, assign) id <HYZPromotionDetailCellDelegate>
                                            cellDelegate;

@property (nonatomic, strong) UILabel       *smallpromotionLable;

@property (nonatomic, strong) UIImageView   *smallImageView;

@property (nonatomic, strong) UILabel       *titleLable;

@property (nonatomic, strong) UIImageView   *activityImageView;

@property (nonatomic, strong) UILabel       *themeLable;

@property (nonatomic, strong) UILabel       *detailLable;

@property (nonatomic, strong) UILabel       *begainTimeLable;

@property (nonatomic, strong) UIButton      *shareButton;

- (void)creatSubViews;

@end
