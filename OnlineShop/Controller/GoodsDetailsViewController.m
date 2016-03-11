//
//  GoodsDetailsViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "GoodsDetailsViewController.h"
#import "FirstTableViewCell.h"
#import "CycleScrollView.h"
#import "ImageView.h"
#import "BYShopCartViewController.h"
#import "UIImageView+WebCache.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "WeiPuLoginViewController.h"
#import "ManMessageViewController.h"
#import "WebPictureViewController.h"
#import "MBProgressHUD.h"
static NSString * joinCart = @"joinCart";
static NSString * goodDetail = @"goodDetail";
@interface GoodsDetailsViewController ()< UIAlertViewDelegate, UIWebViewDelegate>
{
    UITableView * _tableView;
//    UILabel     * _nameLabel;
//    UILabel     * _originalPrice;
//    UILabel     * _descriptionLabel;
//    UILabel     * _nowPrice;
    UIImageView * _imageView;
    UILabel     * _nameLabel;
    UILabel     * _yPrice;
    UILabel     * _cPrice;
    UILabel     * _state;
    UIView      * _footerView;
    NSArray     * _receiveArray;
    UIWebView   * _webView;
}
@property(nonatomic, strong)CycleScrollView * baseScrollView;
@end

@implementation GoodsDetailsViewController
    //商品详情
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商品详情";
        self.begin = YES;
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:joinCart object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(joinCartSuccefull:) name:joinCart object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goodDetailSucceful:) name:goodDetail object:nil];
    [self initWithControlView];
    [self goodsDetailRequest];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)goodsDetailRequest
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.goods.detail.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&isIntroduction=yes&goodsId=%@", time, _goodID];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:goodDetail];
}
- (void)goodDetailSucceful:(NSNotification *)notification
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSData * data = [notification object];
    _receiveDic = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"goodsDetail"];
    [_imageView setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:nil];
    _nameLabel.text = [_receiveDic objectForKey:@"fullName"];
    _yPrice.text = [NSString stringWithFormat:@"原价:¥%@.00",[_receiveDic objectForKey:@"marketPrice"]];
    _cPrice.text = [NSString stringWithFormat:@"现价:¥%@.00", [_receiveDic objectForKey:@"price"]];

}

- (void)initWithControlView
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, self.view.bounds.size.height/2)];
    _imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imageView];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x,_imageView.frame.origin.y + _imageView.bounds.size.height, 320, self.view.bounds.size.height - _imageView.bounds.size.height - 64)];
    view.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    _nameLabel.backgroundColor = BACKGROUND_COLOR;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:14.0];
    _nameLabel.textColor = [UIColor orangeColor];
    [view addSubview:_nameLabel];
    
    _yPrice = [[UILabel alloc] initWithFrame:CGRectMake(_nameLabel.frame.origin.x, _nameLabel.frame.origin.y + _nameLabel.bounds.size.height+1, 320, 20)];
    _yPrice.backgroundColor = BACKGROUND_COLOR;
    _yPrice.textAlignment = NSTextAlignmentCenter;
    _yPrice.textColor = [UIColor grayColor];
    _yPrice.font = [UIFont systemFontOfSize:12.0];
    [view addSubview:_yPrice];
    _cPrice = [[UILabel alloc] initWithFrame:CGRectMake(_yPrice.frame.origin.x, _yPrice.frame.origin.y + _yPrice.bounds.size.height, 320, 20)];
    _cPrice.backgroundColor = BACKGROUND_COLOR;
    _cPrice.textAlignment = NSTextAlignmentCenter;
    _cPrice.textColor = [UIColor orangeColor];
    [view addSubview:_cPrice];
    
    _state = [[UILabel alloc] initWithFrame:CGRectMake(_cPrice.frame.origin.x, _cPrice.frame.origin.y + _cPrice.bounds.size.height + 1, 320, 30)];
    _state.backgroundColor = BACKGROUND_COLOR;
    _state.text = [NSString stringWithFormat:@"    图文详情"];
    _state.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushState)];
    [_state addGestureRecognizer:tap];
    [view addSubview:_state];

    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, _state.frame.origin.y + _state.bounds.size.height + 1, 320, view.bounds.size.height - _state.frame.origin.y - _state.bounds.size.height - 1)];
    _footerView.backgroundColor = BACKGROUND_COLOR;
    [view addSubview:_footerView];
    
    UIButton * onceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [onceButton setTitle:@"立即购买" forState:UIControlStateNormal];
    onceButton.frame = CGRectMake(30, 15, 115, 30);
    onceButton.layer.cornerRadius = 15.0;
    if (self.begin) {
        [onceButton addTarget:self action:@selector(onceDidBuy) forControlEvents:UIControlEventTouchUpInside];
        onceButton.backgroundColor = [UIColor orangeColor];
    }else{
        onceButton.backgroundColor = [UIColor grayColor];
    }
    
    [_footerView addSubview:onceButton];
    
    UIButton * cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartButton setTitle:@"添加到购物车" forState:UIControlStateNormal];
    cartButton.layer.cornerRadius = 15.0;
    if (self.begin) {
        cartButton.backgroundColor = [UIColor redColor];
        [cartButton addTarget:self action:@selector(joinShopCart) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cartButton.backgroundColor = [UIColor grayColor];
    }
    cartButton.frame = CGRectMake(onceButton.frame.origin.x + onceButton.bounds.size.width + 30, onceButton.frame.origin.y, 115, 30);
    [_footerView addSubview:cartButton];
}
- (void)pushState
{
    WebPictureViewController * webPicture = [[WebPictureViewController alloc] init];
    webPicture.htmlString = [_receiveDic objectForKey:@"introduction"];
    [self.navigationController pushViewController:webPicture animated:YES];
}
- (void)onceDidBuy
{
  if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Succeful"]) {
        ManMessageViewController * manMessageViewController = [[ManMessageViewController alloc] init];
        manMessageViewController.receiveArray = [NSArray arrayWithObjects:_receiveDic, nil];
        float price = [[_receiveDic objectForKey:@"price"] floatValue];
        manMessageViewController.sendSumPrice = [NSString stringWithFormat:@"1件商品共计:¥%.2f", price];
        [self.navigationController pushViewController:manMessageViewController animated:YES];
        return;
   }
    WeiPuLoginViewController * loginViewController = [[WeiPuLoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)joinShopCart
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Succeful"]) {
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[WeiPuLoginViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    int quantity = 1;
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.cart.item.add&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&goodsId=%@&memberId=%@&quantity=%d", time, _goodID, MEMBERID, quantity];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,  keyValues,sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:joinCart];
}
- (void)joinCartSuccefull:(NSNotification *)nsnotification
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSLog(@"===========%@", [NSJSONSerialization JSONObjectWithData:[nsnotification object] options:0 error:nil]);
    NSData * data = nsnotification.object;
    NSString * resultCode = [NSString stringWithFormat:@"%@", [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"resultCode"]];
    if ([resultCode isEqualToString:@"0"]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的商品已成功添加到购物车" delegate:self cancelButtonTitle:@"再逛逛" otherButtonTitles:@"去购物车", nil];
        [alertView show];
    }
}
#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
#pragma mark - UIAlertView
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        BYShopCartViewController * byShopCart = [[BYShopCartViewController alloc] init];
        [self.navigationController pushViewController:byShopCart animated:YES];
    }if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (CGFloat)heightLableUIFont:(UIFont *)font sendString:(NSString *)str width:(NSUInteger)width
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect textRect = [str boundingRectWithSize:CGSizeMake(width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return textRect.size.height;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
#pragma mark UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
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
