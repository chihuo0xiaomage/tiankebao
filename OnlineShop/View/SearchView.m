//
//  SearchView.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-11-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "SearchView.h"

@interface SearchView ()
{
    id  _target;
    SEL _action;
}
@end

@implementation SearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame target:(id)target section:(SEL)section
{
    self = [super initWithFrame:frame];
    if (self) {
        _target = target;
        _action = section;
        
        self.backgroundColor = BACKGROUND_COLOR;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 34)];
        self.imageView.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.imageView];
        self.searchText = [[UITextField alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.bounds.size.width, _imageView.frame.origin.y, 220, 34)];
        self.searchText.placeholder = @"请输入您要搜索的商品";
        self.searchText.borderStyle = UITextBorderStyleRoundedRect;
        self.searchText.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:self.searchText];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.searchButton setTitle:@"取消" forState:UIControlStateNormal];
        self.searchButton.frame = CGRectMake(_searchText.frame.origin.x + _searchText.bounds.size.width, _searchText.frame.origin.y, 40, 34);
        [_searchButton addTarget:self action:@selector(searchButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.searchButton];
    }
    return self;
}
- (void)searchButtonSelector:(UIButton *)button
{
    [_searchText resignFirstResponder];
    if (_target && [_target respondsToSelector:_action]) {
        [_target performSelector:_action withObject:nil afterDelay:0.0];
    }
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
