//
//  HYZCarCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCarCell.h"

@implementation HYZCarCell

@synthesize goodNameLable = _goodNameLable, priceLable = _priceLable;

@synthesize numberTextField = _numberTextField;

@synthesize subtractButton = _subtractButton, addButton = _addButton, deleteButton = _deleteButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(NSString *)tag
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = BACKGROUND_COLOR;
        
        [self creatSubViewsTag:tag];
    }
    return self;
}

- (void)creatSubViewsTag:(NSString *)tag
{
    _goodNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 249, 30)];
    
    _goodNameLable.backgroundColor = [UIColor whiteColor];
    
    _goodNameLable.font = [UIFont systemFontOfSize:15];
    
    [self.contentView addSubview:_goodNameLable];
    
    
    
    _priceLable = [[UILabel alloc] initWithFrame:CGRectMake(250, 0, 80, 30)];
    
    _priceLable.backgroundColor = [UIColor whiteColor];
    
    _priceLable.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:_priceLable];
    
    
    _deleteButton = [[HYZCarButtonImageView alloc] initWithFrame:CGRectMake(0, 31, 79, 30) buttonTag:[NSString stringWithFormat:@"dlt%@",tag]];
    
    _deleteButton.delegate = self;
    
    _deleteButton.backgroundColor = [UIColor whiteColor];
    
    _deleteButton.backgroundImageView.image = [UIImage imageNamed:@"cart_icon_delete.png"];
    
    [self.contentView addSubview:_deleteButton];
    
    
    _subtractButton = [[HYZCarButtonImageView alloc] initWithFrame:CGRectMake(80, 31, 79, 30) buttonTag:[NSString stringWithFormat:@"sub%@",tag]];
    
    _subtractButton.backgroundColor = [UIColor whiteColor];
    
    _subtractButton.delegate = self;
    
    _subtractButton.backgroundImageView.image = [UIImage imageNamed:@"cart_icon_jian.png"];
    
    [self.contentView addSubview:_subtractButton];
    
    
    
    _numberTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 30, 79, 30)];
    
    _numberTextField.borderStyle = UITextBorderStyleRoundedRect;
        
    _numberTextField.delegate = self;
    
    _numberTextField.tag = [tag intValue];
    
    _numberTextField.userInteractionEnabled = NO;
    
    _numberTextField.layer.cornerRadius = 1.0;
    
    _numberTextField.font = [UIFont systemFontOfSize:20];
    
    [self.contentView addSubview:_numberTextField];
    
    
    _addButton = [[HYZCarButtonImageView alloc] initWithFrame:CGRectMake(240, 31, 80, 30) buttonTag:[NSString stringWithFormat:@"add%@",tag]];
    
    _addButton.delegate = self;
    
    _addButton.backgroundColor = [UIColor whiteColor];
    
    _addButton.backgroundImageView.image = [UIImage imageNamed:@"cart_icon_jia.png"];
    
    [self.contentView addSubview:_addButton];
}

- (void)imageViewButtonClicked:(UITapGestureRecognizer *)UITapGestureRecognizer
{
    if ([_cellDelegate respondsToSelector:@selector(cellImageButtonClicked:)]) {
        [_cellDelegate cellImageButtonClicked:UITapGestureRecognizer];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
