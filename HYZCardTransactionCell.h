//
//  HYZCardTransactionCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZButtonView.h"

@protocol HYZCardTransactionCellDelegate <NSObject>

- (void)buttonClicked:(NSString *)tag;

@end

@interface HYZCardTransactionCell : UITableViewCell<HYZButtonViewDelegate>

@property (nonatomic, assign)id <HYZCardTransactionCellDelegate> delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageNameArray:(NSArray *)image titleLableNameArray:(NSArray *)title;

- (void)creatCustomCellimageNameArray:(NSArray *)image titleLableNameArray:(NSArray *)title;

@end
