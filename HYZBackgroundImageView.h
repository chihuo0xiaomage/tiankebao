//
//  HYZBackgroundImageView.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-9.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYZBackgroundImageViewDelegate <NSObject>

- (void)imageClick:(NSString *)tag;

@end

@interface HYZBackgroundImageView : UIImageView

@property (nonatomic, assign) id <HYZBackgroundImageViewDelegate>   delegate;

- (id)initWithFrame:(CGRect)frame image:(UIImage *)image tag:(NSString *)tag;

@end
