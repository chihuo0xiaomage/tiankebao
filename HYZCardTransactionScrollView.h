//
//  HYZCardTransactionScrollView.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZScrollerImageView.h"

@protocol HYZCardTransactionScrollViewDelegate <NSObject>

- (void)imageTouchUpInside:(NSString *)tag;

@end

@interface HYZCardTransactionScrollView : UIScrollView<HYZScrollerImageViewDelegate>

@property (nonatomic, assign)id <HYZCardTransactionScrollViewDelegate> scrollDelegate;

- (id)initWithFrame:(CGRect)frame imageNameArray:(NSArray *)array;

- (void)addScrollViewSubview:(UIView *)view imageNameArray:(NSArray *)array;

@end
