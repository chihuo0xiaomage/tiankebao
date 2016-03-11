//
//  BYOnlineShopViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYOnlineShopViewController.h"
#import "BYCategoryProductsViewController.h"
#import "FirstTableViewCell.h"
#import "BYShopCartViewController.h"
#import "SecondTableViewCell.h"
#import "ThirdTableViewCell.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "BYDetailViewController.h"
#import "BYRecommendViewController.h"
#import "BYGoodViewController.h"
#import "WeiPuLoginViewController.h"
#import "BYAlipay.h"
#import "GoodsDetailsViewController.h"
#import "BYSetViewController.h"
#import "TodayViewController.h"
#import "MBProgressHUD.h"
#import "MJRefresh.h"
static NSString * const onlineImage = @"onlineImage";
static NSString * const onlineData = @"onlineData";
static NSString * const imageArray = @"imageArray";
@interface BYOnlineShopViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray     * _receiveArray;
    NSArray     * _imageArray;
    UIImageView * _searchBox;
}
@end

@implementation BYOnlineShopViewController

    //网购界面
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"网购";
        self.tabBarItem.title = @"网购";
        self.tabBarItem.image = [UIImage imageNamed:@"icon_2_n.png"];
    }
    return self;
}
#pragma mark - nsnotification
    //当点击滚动视图的时候进入到一个web页面
- (void)goToDetail:(NSNotification *)notification
{
    BYDetailViewController * detailVC = [[BYDetailViewController alloc] init];
    detailVC.nsnotification = notification;
    [self.navigationController pushViewController:detailVC animated:YES];
}
    //推出推荐页面
- (void)pushBYRecommend:(NSNotification *)notification
{
    BYRecommendViewController * recommendVC = [[BYRecommendViewController alloc] init];
    recommendVC.notification = notification;
    [self.navigationController pushViewController:recommendVC animated:YES];
}
    //推出秒杀页面
- (void)pushBYgood:(NSNotification *)notification
{
    BYGoodViewController * goodVC = [[BYGoodViewController alloc] init];
        //goodVC.notification = notification;
    [self.navigationController pushViewController:goodVC animated:YES];
}

    //没有使用
- (void)oneDetail:(NSNotification *)notification
{
    TodayViewController * today = [[TodayViewController alloc] init];
    [self.navigationController pushViewController:today animated:YES];
}
    //移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:onlineImage object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"urlDic" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BYRECOMMEND" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GOOD" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"resultCode" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Detail" object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        //注册通知
        //注册通知回调轮播图片数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succefullOnlineImage:) name:onlineImage object:nil];
        //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToDetail:) name:@"urlDic" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBYRecommend:) name:@"BYRECOMMEND" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushBYgood:) name:@"GOOD" object:nil];
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(byShopCart) name:@"resultCode" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(oneDetail:) name:@"WebView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backData:) name:imageArray object:nil];
        //UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleDone target:self action:@selector(pushCategoryProducts)];
    UIBarButtonItem * leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"liebiao.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(pushCategoryProducts)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;


    UIBarButtonItem * quit = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"shezhi.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(quitLogin)];
    self.navigationItem.rightBarButtonItems = @[quit,];
        //初始化tableview
        //[self createAsearchBox];
    [self initWithTableView];
    [self setupRefresh];
        //开始请求数据
    [self startRequest];
    [self startRequestThirdImage];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)setupRefresh
{
    [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
}
- (void)headerRefresh
{
    [self refreshRequest];
}
- (void)refreshRequest
{
    [self startRequest];
    [self startRequestThirdImage];
}
- (void)endNetworkingRefresh
{
    [_tableView headerEndRefreshing];
}
#pragma mark - 网络请求数据
- (void)startRequestThirdImage
{
    CGFloat time = [Encrypt timeInterval];
        //拼接接口
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.product.goods.wonderfulshow&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone", time];
        //进行加密
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        //开始网络请求
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:imageArray];
}
    //开始请求数据
- (void)startRequest
{
        //当前的时间戳
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    CGFloat time = [Encrypt timeInterval];
        //拼接接口
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.homepage.carousel.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone", time];
        //进行加密
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        //开始网络请求
    [NetWorking NetWorkingURL:urlStr target:self action:nil identifier:onlineImage];
}
    //请求轮播图片
- (void)backData:(NSNotification *)notification
{
    NSData * data = notification.object;
    NSLog(@"-----------------%@", [NSJSONSerialization JSONObjectWithData:[notification object] options:0 error:nil]);
    if (data != NULL) {
        
        _imageArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"wonderfulShowList"];
        NSLog(@"_imageArray = =======%@", _imageArray);
        [_tableView reloadData];
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self endNetworkingRefresh];
}
    //请求成功 请求今日推荐里面的数据
- (void)succefullOnlineImage:(NSNotification *)notification
{
    NSData * data = notification.object;
    if (data != NULL) {
        _receiveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"caroursels"];
        [_tableView reloadData];
    }
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self endNetworkingRefresh];
    
}
- (void)quitLogin
{
    [self.navigationController pushViewController:[[BYSetViewController alloc] init] animated:YES];
}
    //分类商品
- (void)pushCategoryProducts
{
    BYCategoryProductsViewController * byCategoryProducetsViewController = [[BYCategoryProductsViewController alloc] init];
    [self.navigationController pushViewController:byCategoryProducetsViewController animated:YES];
}
- (void)initWithTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = _searchBox;
    [self.view addSubview:_tableView];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 160;
    }else if (indexPath.row == 1){
        return 88;
    }
    return 360;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0) {
            static NSString * CellIdentfier = @"Section0Row0Cell";
            FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
            if (cell == nil) {
            cell = [[FirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (_receiveArray != NULL) {
                cell.array = _receiveArray;
            }
            return cell;
        }
        if (indexPath.row == 1) {
            static NSString * CellIdentfier = @"Section0Row1Cell";
            SecondTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
            if (cell == nil) {
                cell = [[SecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    static NSString * CellIdentfier = @"cell";
    ThirdTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell == nil) {
        cell = [[ThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.array = _imageArray;
    return cell;
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
