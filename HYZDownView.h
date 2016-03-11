//
//  HYZDownView.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYZDownViewDelegate <NSObject>

- (void)sure:(NSString *)cardNumber;

@end

@interface HYZDownView : UIView<UIActionSheetDelegate>

@property (nonatomic, assign) id <HYZDownViewDelegate>  delegate;

@property (nonatomic, strong) UIButton                  *cardButton;

@property (nonatomic, strong) NSMutableArray            *messageArray;

@property (nonatomic, strong) UIButton                   *sureButton;

@end
