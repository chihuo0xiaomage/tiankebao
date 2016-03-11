//
//  HYZSearchView.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZSearchView.h"

@implementation HYZSearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTheSearchBar];
    }
    return self;
}

- (void)addTheSearchBar
{
    HYZMainSearchBar *searchBar = [[HYZMainSearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    searchBar.placeholder = @"请输入搜索关键字        ";
    
    searchBar.barTintColor = [UIColor clearColor];
    
    searchBar.barStyle = UIBarStyleDefault;
    
    [self addSubview:searchBar];
}

@end
