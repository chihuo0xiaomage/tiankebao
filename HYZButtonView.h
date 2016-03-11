//
//  HYZButtonView.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZUITapGestureRecognizer+Tag.h"

@protocol HYZButtonViewDelegate <NSObject>

- (void)imageViewClicked:(NSString *)tag;

@end

@interface HYZButtonView : UIView

@property (nonatomic, assign)id <HYZButtonViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)labeltext;

- (void)creatMyButtonBackgroundImageName:(NSString *)imageName title:(NSString *)labeltext;

- (void)creatSmallImageViewAndLable:(UIImageView *)imageView imageName:(NSString *)imageName title:(NSString *)labeltext;

@end
