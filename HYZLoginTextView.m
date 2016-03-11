//
//  HYZLoginTextView.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZLoginTextView.h"

@implementation HYZLoginTextView

@synthesize textField = _textField;

- (id)initWithFrame:(CGRect)frame leftImageName:(NSString *)nameString placeholderString:(NSString *)placeholderString
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = BACKGROUND_COLOR;
        
        UIView *smallView = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 39, 33)];
        smallView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:smallView];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3, 39, 27)];
        
        imageView.image = [UIImage imageNamed:nameString];
        
        [smallView addSubview:imageView];
        
        
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 1, self.bounds.size.width - 41, self.bounds.size.height -2)];
        
        _textField.borderStyle = UITextBorderStyleNone;
        
        _textField.backgroundColor = [UIColor whiteColor];
        
        _textField.placeholder = placeholderString;
        
        _textField.delegate = self;
        
        _textField.font = [UIFont systemFontOfSize:20];
        
        [self addSubview:_textField];

    }
    return self;
}

@end
