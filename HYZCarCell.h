//
//  HYZCarCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZUITapGestureRecognizer+Tag.h"

#import "HYZCarButtonImageView.h"

@protocol HYZCarCellDelegate <NSObject>

- (void)cellImageButtonClicked:(UITapGestureRecognizer *)UITapGestureRecognizer;

@end

@interface HYZCarCell : UITableViewCell<UITextFieldDelegate,HYZCarButtonImageViewDelegate>

@property (nonatomic, assign) id <HYZCarCellDelegate>        cellDelegate;

@property (nonatomic, strong) UILabel                        *goodNameLable;

@property (nonatomic, strong) UILabel                        *priceLable;

@property (nonatomic, strong) UITextField                    *numberTextField;

@property (nonatomic, strong) HYZCarButtonImageView          *subtractButton;

@property (nonatomic, strong) HYZCarButtonImageView          *addButton;

@property (nonatomic, strong) HYZCarButtonImageView          *deleteButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(NSString *)tag;

@end
