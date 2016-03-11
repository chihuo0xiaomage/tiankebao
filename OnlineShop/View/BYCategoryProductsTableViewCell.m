//
//  BYCategoryProductsTableViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYCategoryProductsTableViewCell.h"
#import "BYCatelogs.h"
#import "UIImageView+WebCache.h"
@implementation BYCategoryProductsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.aImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
            //self.aImageView.backgroundColor = [UIColor redColor];
        [self addSubview:self.aImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_aImageView.frame.origin.x + _aImageView.bounds.size.width + 10, _aImageView.frame.origin.y, 120, 40)];
        [self addSubview:self.nameLabel];
    }
    return self;
}
- (void)setByCatelogs:(BYCatelogs *)byCatelogs
{
    if (_byCatelogs != byCatelogs) {
        _byCatelogs = byCatelogs;
    }
    NSString * imageUrl = [_byCatelogs.icon stringByReplacingOccurrencesOfString:@".jpg" withString:@"-100-100.jpg"];
    [self.aImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    self.nameLabel.text = _byCatelogs.name;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
