//
//  TodayViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-10-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "TodayViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
static NSString * const today = @"TODAY";
@interface TodayViewController ()

@end

@implementation TodayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(todayDataSuccful:) name:today object:nil];
   [self todayStartQuestData];
}
- (void)todayStartQuestData
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.product.search.goods.byRecommend.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone", time];
        //进行加密
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        //开始网络请求
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:today];
}
#pragma mark - nsnotification
- (void)todayDataSuccful:(NSNotification *)nsnotification
{
        //NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:[nsnotification object] options:0 error:nil]);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
