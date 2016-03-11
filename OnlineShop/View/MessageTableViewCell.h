//
//  MessageTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property(nonatomic, strong)UILabel * nameLabel;
@property(nonatomic, strong)UILabel * phoneLabel;
@property(nonatomic, strong)UILabel * addressLabel;

@property(nonatomic, strong)NSDictionary * messageDic;
@end
