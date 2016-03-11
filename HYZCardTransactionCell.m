//
//  HYZCardTransactionCell.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZCardTransactionCell.h"

@implementation HYZCardTransactionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageNameArray:(NSArray *)image titleLableNameArray:(NSArray *)title
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        创建cell上得控件
        [self creatCustomCellimageNameArray:image titleLableNameArray:title];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)creatCustomCellimageNameArray:(NSArray *)image titleLableNameArray:(NSArray *)title
{
    for (int i=0; i<[image count]; i++)
    {
		int x=(i%4)+ 80 *(i%4);
        
		int y=(i/4+1) + 80*(i/4);
        		
        HYZButtonView *buttonView = [[HYZButtonView alloc] initWithFrame:CGRectMake(x, y, 80, 80) imageName:[image objectAtIndex:i] title:[title objectAtIndex:i]];
        
        buttonView.delegate = self;
        
		[self.contentView addSubview:buttonView];
	}
}

#pragma mark -

#pragma mark HYZButtonViewDelegate -

- (void)imageViewClicked:(NSString *)tag
{
    if ([_delegate respondsToSelector:@selector(buttonClicked:)])
    {
        [_delegate buttonClicked:tag];
    }
}


@end
