//
//  HYZMineCell.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYZMineCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier headPortraitImage:(NSString *)imageString userName:(NSString *)nameString CardNumber:(NSString *)numberString;

- (void)creatUiHeadPortraitImage:(NSString *)imageString userName:(NSString *)nameString CardNumber:(NSString *)numberString;

@end
