//
//  ThirdTableViewCell.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SecondView;
@interface ThirdTableViewCell : UITableViewCell
@property(nonatomic, strong)NSArray * array;
@property(nonatomic, strong)NSMutableArray * imageArray;
@property(nonatomic, strong)SecondView * secondView;
@property(nonatomic, strong)UIImageView * aImageView;
@end
