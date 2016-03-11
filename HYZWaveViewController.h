//
//  HYZWaveViewController.h
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>

@interface HYZWaveViewController : UIViewController

@property (nonatomic, assign) SystemSoundID soundID;

@property (nonatomic, strong) UILabel       *lable;

@end
