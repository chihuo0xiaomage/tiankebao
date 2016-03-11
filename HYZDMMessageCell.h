//
//  HYZDMMessageCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZBackgroundImageView.h"

#import "STTweetLabel.h"

@protocol HYZDMMessageCellDelegate <NSObject>

- (void)backgroundImageClick:(NSString *)tag;

@end

@interface HYZDMMessageCell : UITableViewCell<HYZBackgroundImageViewDelegate,STLinkProtocol>

@property (nonatomic, assign) id <HYZDMMessageCellDelegate> cellDelegate;

@property (nonatomic, strong) UILabel       *titleLable;

@property (nonatomic, strong) STTweetLabel  *messageLable;

@property (nonatomic, strong) UIImageView   *dmImageView;

@property (nonatomic, strong) UILabel       *createDateLable;

@property (nonatomic, strong) UILabel       *tenantcodeLable;

@property (nonatomic, strong) UILabel       *pingjiaLale;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier image:(UIImage *)image tag:(NSString *)tag height:(float)height messageType:(int)type;


@end
