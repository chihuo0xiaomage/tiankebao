//
//  SearchView.h
//  WeiPeng
//
//  Created by 宝源科技 on 14-11-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIView

@property(nonatomic, strong)UITextField * searchText;
@property(nonatomic, strong)UIImageView * imageView;
@property(nonatomic, strong)UIButton    * searchButton;
- (id)initWithFrame:(CGRect)frame target:(id)target section:(SEL)section;
@end
