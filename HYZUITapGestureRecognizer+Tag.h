//
//  HYZUITapGestureRecognizer+Tag.h
//  WeiPu
//
//  Created by 韩亚周 on 13-12-16.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

@interface UITapGestureRecognizer (tag)

@property (nonatomic) NSString *tag;

@end
