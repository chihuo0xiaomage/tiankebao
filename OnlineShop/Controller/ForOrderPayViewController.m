//
//  ForOrderPayViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-11-19.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ForOrderPayViewController.h"

@interface ForOrderPayViewController ()
{
    int   _number;
    float _price;
    
}
@end

@implementation ForOrderPayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"结算";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    for (NSDictionary * dic in [_receiveDic objectForKey:@"goods"]) {
        _number += [[dic objectForKey:@"quantity"] intValue];
    }
    UIView * view = [self viewWithFrame:CGRectMake(0, 64, 320, 44)];
    [self.view addSubview:view];
}
- (UIView *)viewWithFrame:(CGRect)frame
{
    UIView * view = [[UIView alloc] initWithFrame:frame ];
    view.backgroundColor = [UIColor blackColor];
    UILabel * numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 80, 44)];
    numberLabel.textAlignment = NSTextAlignmentCenter;
        //numberLabel.backgroundColor = [UIColor yellowColor];
    numberLabel.textColor = [UIColor whiteColor];
    numberLabel.text = [NSString stringWithFormat:@"数量:%d", _number];
    [view addSubview:numberLabel];
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(numberLabel.frame.origin.x + numberLabel.bounds.size.width, numberLabel.frame.origin.y, 140, 44)];
        //priceLabel.backgroundColor = [UIColor redColor];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.text = [NSString stringWithFormat:@"金额:%.2f", [[_receiveDic objectForKey:@"totalAmount"] floatValue]];
    priceLabel.textColor = [UIColor whiteColor];
    [view addSubview:priceLabel];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(priceLabel.frame.origin.x + priceLabel.bounds.size.width, priceLabel.frame.origin.y, 80, 44);
        //button.backgroundColor = [UIColor yellowColor];
//    if (<#condition#>) {
//        <#statements#>
//    }
    [button setTitle:@"等待付款" forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
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
