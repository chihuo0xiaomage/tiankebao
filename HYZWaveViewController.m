//
//  HYZWaveViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-2-13.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZWaveViewController.h"

@interface HYZWaveViewController ()

@end

@implementation HYZWaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"摇一摇";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _lable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height/2 - 50, 320, 100)];
    
    _lable.numberOfLines = 0;
    
    _lable.autoresizesSubviews = YES;
    _lable.text = @"摇一摇可能会要出您想不出的东西呀!";
    _lable.textAlignment = NSTextAlignmentCenter;
    
    _lable.font = [UIFont systemFontOfSize:35];
    
    _lable.textColor = [UIColor redColor];
    
    [self.view addSubview:_lable];
    
    
    
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
}

- (void) motionBegan:(UIEventSubtype)motion
           withEvent:(UIEvent *)event
{
//    NSLog(@"检测摇动");
    
    _lable.text = @"开始摇动";
    
    [self sound:@"shake_sound_male"];
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//    NSLog(@"取消摇动");
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.subtype == UIEventSubtypeMotionShake) {
//        NSLog(@"%d++++",event.subtype);
//            NSLog(@"something happens摇动结束");
        
        _lable.text = @"什么都没摇出来";
        
        [self sound:@"shake_match"];
        }
}

- (void)sound:(NSString *)nameString{
        //创建音乐文件路径
    NSString *thesoundFilePath = [[NSBundle mainBundle] pathForResource:nameString ofType:@"wav"];
    
        //变量SoundID与URL对应
    CFURLRef thesoundURL = (__bridge CFURLRef) [NSURL fileURLWithPath:thesoundFilePath];
    
    AudioServicesCreateSystemSoundID(thesoundURL, &_soundID);
    
        //播放SoundID声音
    AudioServicesPlaySystemSound(_soundID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
