//
//  HYZServerButtonImageView.h
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-25.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HYZUITapGestureRecognizer+Tag.h"

@protocol HYZServerButtonImageViewDelegate <NSObject>

- (void)imageButtonClicked:(NSString *)tag;

@end

@interface HYZServerButtonImageView : UIImageView

@property (nonatomic, assign)id <HYZServerButtonImageViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame smallImageName:(NSString *)string titleText:(NSString *)titleString;

- (void)addSmallImageViewAndLableSmallImageName:(NSString *)string titleText:(NSString *)titleString;

@end
