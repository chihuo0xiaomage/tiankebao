//
//  HYZPromotionCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYZPromotionCellDelegate <NSObject>

-(void)shareButtonClicke:(UIButton *)sender;

@end

@interface HYZPromotionCell : UITableViewCell

@property (nonatomic, assign) id <HYZPromotionCellDelegate>   cellDelegate;

@property (nonatomic, strong) UIImageView                     *smallImageView;

@property (nonatomic, strong) UILabel                         *titleLable;

@property (nonatomic, strong) UIImageView                     *activityImageView;

@property (nonatomic, strong) UILabel                         *titleTimeLable;

@property (nonatomic, strong) UILabel                         *detailLable;

@property (nonatomic, strong) UILabel                         *begainTimeLable;

@property (nonatomic, strong) UIButton                        *shareButton;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier headImage:(NSString *)nameString title:(NSString *)titleString;

- (void)creatUiheadImage:(NSString *)nameString title:(NSString *)titleString;

@end
