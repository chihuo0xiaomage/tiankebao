//
//  HYZMessageCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYZMessageCell : UITableViewCell

@property (nonatomic, strong) UIImageView       *leftImageView;

@property (nonatomic, strong) UILabel           *shopNameLable;

@property (nonatomic, strong) UIImageView       *rightImageView;

- (void)creatSubView;

@end
