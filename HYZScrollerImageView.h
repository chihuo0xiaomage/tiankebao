//
//  HYZScrollerImageView.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYZScrollerImageViewDelegate <NSObject>

- (void)imageTouched:(NSString *)tag;

@end

@interface HYZScrollerImageView : UIImageView

@property (nonatomic, assign) id <HYZScrollerImageViewDelegate>delegate;

- (id)initWithFrame:(CGRect)frame imageViewTag:(NSString *)tag;

- (void)touchUpInsideimageViewTag:(NSString *)tag;

@end
