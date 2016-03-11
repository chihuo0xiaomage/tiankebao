//
//  HYZLoginTextView.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYZLoginTextView : UIView<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * textField;

- (id)initWithFrame:(CGRect)frame leftImageName:(NSString *)nameString placeholderString:(NSString *)placeholderString;

@end
