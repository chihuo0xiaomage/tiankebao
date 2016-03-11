    //
    //  MoreProductsViewController.m
    //  WeiPeng
    //
    //  Created by 宝源科技 on 14-8-15.
    //  Copyright (c) 2014年 apple. All rights reserved.
    //

#import "MoreProductsViewController.h"
#import "ProductTableViewCell.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "Products.h"
#import "GoodsDetailsViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
static NSString * const moreProducts = @"moreProducts";
@interface MoreProductsViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    int           _pageNumber;
    NSArray     * _receiveArray;
    NSMutableArray * _moreProductArray;
    BOOL          _header;
    BOOL          _footer;
    BOOL          _first;
}
@end

@implementation MoreProductsViewController

    //商品
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"商品";
        _pageNumber = 1;
        _first = YES;
        _moreProductArray = [NSMutableArray array];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:moreProducts object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moreProductsRequestSucceful:) name:moreProducts object:nil];
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    [self setupRefresh];
    [self moreProductsRequest:_pageNumber];
}
- (void)setupRefresh
{
    [_tableView addHeaderWithTarget:self action:@selector(headerRefresh)];
    [_tableView addFooterWithTarget:self action:@selector(footerRefresh)];
}
- (void)headerRefresh
{
        //NSLog(@"下拉刷新");
    _header = YES;
    [self refreshRequest];
}
- (void)footerRefresh
{
        //NSLog(@"上拉加载更多");
    _footer = YES;
    [self refreshRequest];
}
- (void)refreshRequest
{
    if (_header) {
        _pageNumber = 1;
        [self moreProductsRequest:_pageNumber];
    }
    if (_footer) {
        _pageNumber++;
        [self moreProductsRequest:_pageNumber];
    }
}
- (void)moreProductsRequest:(int)pageNumber
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.search.goods.byCatelog.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&pageNumber=%d&pageSize=10&catelogId=%@", time, _pageNumber, self.cid];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:moreProducts];
}
- (void)moreProductsRequestSucceful:(NSNotification *)notification
{
    NSData * data = notification.object;
    _receiveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"goods"];
        //NSLog(@"_receiveArray = %@", _receiveArray);
    if (_first) {
        for (NSDictionary * dic in _receiveArray) {
            Products * product = [[Products alloc] initWithMoreProductsNSDictionary:dic];
            [_moreProductArray addObject:product];
        }
        [_tableView reloadData];
        _first = NO;
    }
    if (_header) {
        [_moreProductArray removeAllObjects];
        for (NSDictionary * dic in _receiveArray) {
            Products * product = [[Products alloc] initWithMoreProductsNSDictionary:dic];
            [_moreProductArray addObject:product];
        }
        [_tableView reloadData];
        _header = NO;
        [_tableView headerEndRefreshing];
    }
    if (_footer) {
        for (NSDictionary * dic in _receiveArray) {
            Products * product = [[Products alloc] initWithMoreProductsNSDictionary:dic];
            [_moreProductArray addObject:product];
        }
        [_tableView reloadData];
        _footer = NO;
        [_tableView footerEndRefreshing];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsDetailsViewController * goodsDetails = [[GoodsDetailsViewController alloc] init];
    goodsDetails.goodID = ((Products *)[_moreProductArray objectAtIndex:indexPath.row]).gid;
    goodsDetails.imageUrl = ((Products *)[_moreProductArray objectAtIndex:indexPath.row]).imageUrl;
    [self.navigationController pushViewController:goodsDetails animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _moreProductArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentfier = @"cell";
    ProductTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell == nil) {
        cell = [[ProductTableViewCell   alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
    }
    cell.product = [_moreProductArray objectAtIndex:indexPath.row];
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
