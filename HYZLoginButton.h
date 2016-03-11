//
//  HYZLoginButton.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-30.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZUITapGestureRecognizer+Tag.h"

@protocol HYZLoginButtonDelegate <NSObject>

//- (void)HYZQQLoginButtonClicked;

//- (void)HYZSinaLoginButtonClicked;

@end

@interface HYZLoginButton : UIView

@property (nonatomic, assign) id <HYZLoginButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame leftImage:(NSString *)imageNameString title:(NSString *)titleString;

@end
