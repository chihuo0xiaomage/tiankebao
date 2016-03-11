//
//  HYZCarButtonImageView.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZUITapGestureRecognizer+Tag.h"

@protocol HYZCarButtonImageViewDelegate <NSObject>

- (void)imageViewButtonClicked:(UITapGestureRecognizer *)UITapGestureRecognizer;

@end

@interface HYZCarButtonImageView : UIImageView

@property (nonatomic, assign) id <HYZCarButtonImageViewDelegate> delegate;

@property (nonatomic, strong) UIImageView      *backgroundImageView;

- (id)initWithFrame:(CGRect)frame buttonTag:(NSString *)tag;

@end
