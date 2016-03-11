//
//  HYZTopCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-31.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZTopCell.h"

@implementation HYZTopCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier backgroundImage:(UIImage *)image
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUiBackgroundImage:image];
    }
    return self;
}

- (void)creatUiBackgroundImage:(UIImage *)image
{
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 100)];
    
    picImageView.image = image;
    
    [self.contentView addSubview:picImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
