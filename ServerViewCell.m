//
//  ServerViewCell.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-7-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ServerViewCell.h"

@interface ServerViewCell ()
{
    
}

@end

@implementation ServerViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 66, 66)];
            //_imageView.backgroundColor = [UIColor redColor];
        [self addSubview:_imageView];
        
         self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageView.bounds.size.height + 10, 106, 30)];
        _label.textAlignment = NSTextAlignmentCenter;
            //_label.backgroundColor = [UIColor yellowColor];
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:15.0];
        [self addSubview:_label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
