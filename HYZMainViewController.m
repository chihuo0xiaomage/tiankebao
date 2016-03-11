    //
    //  HYZMainViewController.m
    //  WeiPeng
    //
    //  Created by 韩亚周 on 13-12-25.
    //  Copyright (c) 2013年 apple. All rights reserved.
    //

#import "HYZMainViewController.h"

#import "HYZDetailMessageViewController.h"

#import "HYZPromotionViewController.h"

#import "HYZPrepaidPlanViewController.h"

#import "HYZWaveViewController.h"

#import "HYZShoppingCarViewController.h"

#import "HYZWebViewController.h"
@interface HYZMainViewController ()

@end

@implementation HYZMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"首页";
        self.navigationItem.title = @"首页";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_1_n.png"];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        //#define IOS7   ([[[UIDevice currentDevice]systemVersion]floatValue]>=7?YES:NO)
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    _imageNameArray = [[NSArray alloc] initWithObjects:@"home_icon_saoyisao",@"home_icon_yaoyiyao",@"home_icon_chuiyichui",@"home_icon_shanyifu",@"home_icon_chongzhi",@"home_icon_duihuan",@"home_icon_bianmin",@"home_icon_edm", nil];
    _scrollViewImageArray = [[NSArray alloc] initWithObjects:@"t0.png",@"t1.png",@"t2.png",@"t3.png", nil];
    _titleArray = [[NSArray alloc] initWithObjects:@"扫一扫",@"摇一摇",@"幸运转盘", @"刮刮乐",@"充值",@"兑换", @"团购",@"秒杀", nil];
    [self creatUI];
}
- (void)creatUI
{
    _cardTaansactionTabView  = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT - NAVIGATION_HEIGHT - TABBAR_HEIGHT) style:UITableViewStylePlain];
    _cardTaansactionTabView.delegate =self;
    _cardTaansactionTabView.separatorStyle = NO;
    _cardTaansactionTabView.dataSource = self;
    [self.view addSubview:_cardTaansactionTabView];
}
#pragma mark -
#pragma mark UITableViweDataSource -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 163;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0){
        HYZScrollViewCell *cell = [[HYZScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil imageNameArray:_scrollViewImageArray];
        cell.scrollViewImageDelegate = self;
        cell.selected = NO;
        return cell;
    }else if (indexPath.row == 1){
        HYZCardTransactionCell *cell = [[HYZCardTransactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil imageNameArray:_imageNameArray titleLableNameArray:_titleArray];
        cell.delegate = self;
        cell.backgroundColor = BACKGROUND_COLOR;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selected = NO;
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *weiPengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 163)];
        weiPengImageView.image = [UIImage imageNamed:@"home_icon_wp_xc.png"];
        [cell.contentView addSubview:weiPengImageView];
        return cell;
    }
}
#pragma mark -
#pragma mark HYZCardTransactionScrollViewDelegate
- (void)buttonClicked:(NSString *)tag
{
    if ([tag isEqualToString:@"团购"]){
//        [self.navigationController pushViewController:[[HYZConveniencePeopleViewController alloc] init] animated:YES];
        HYZWebViewController * webView = [[HYZWebViewController alloc] init];
        webView.titleString = @"团购";
        webView.urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/tuan.do",URL_HTTP];
        [self.navigationController pushViewController:webView animated:YES];
    }else if ([tag isEqualToString:@"秒杀"]){
//        [self.navigationController pushViewController:[[HYZPromotionViewController alloc] init] animated:YES];
        HYZWebViewController * webView = [[HYZWebViewController alloc] init];
        webView.titleString = @"秒杀";
        webView.urlString = [NSString stringWithFormat:@"%@vipeng/web/lottery/seckill.do",URL_HTTP];
        [self.navigationController pushViewController:webView animated:YES];

    }else if ([tag isEqualToString:@"充值"]){
        [self.navigationController pushViewController:[[HYZPrepaidPlanViewController alloc] init] animated:YES];
    }else if ([tag isEqualToString:@"摇一摇"]){
        [self.navigationController pushViewController:[[HYZWaveViewController alloc] init] animated:YES];
    }else if ([tag isEqualToString:@"扫一扫"]){
        [self.navigationController pushViewController:[[HYZShoppingCarViewController alloc] init] animated:YES];
    }else if ([tag isEqualToString:@"兑换"]){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的积分不足,无法兑换" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
    }else if ([tag isEqualToString:@"幸运转盘"]){
        HYZWebViewController * webView = [[HYZWebViewController alloc] init];
        webView.titleString = @"幸运转盘";
        webView.urlString = @"http://116.255.227.138/vipeng/guajiang/doRquest.do?userId=1&activityId=20";
        [self.navigationController pushViewController:webView animated:YES];
    }else if ([tag isEqualToString:@"刮刮乐"]){
        HYZWebViewController * webView = [[HYZWebViewController alloc] init];
        webView.titleString = @"刮刮乐";
        webView.urlString = @"http://116.255.227.138/vipeng/guajiang/doRquest.do?userId=1&activityId=19";
        [self.navigationController pushViewController:webView animated:YES];
    }
}
#pragma mark -
#pragma mark HYZCardTransactionScrollViewDelegate
- (void)scrollViewImageClicked:(NSString *)tag
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
