//
//  BYGoodViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYGoodViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "ByGoodsTableViewCell.h"
#import "GoodsDetailsViewController.h"
#import "BYHeadView.h"
static NSString * const BYGood = @"BYGOOD";
@interface BYGoodViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray     * _receiveArray;
    BYHeadView  * _headView;
}
@end

@implementation BYGoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"秒杀";
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BYGood object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(byGoodSuccefull:) name:BYGood object:nil];
    [self initWithTableView];
    [self initWithHeaderView];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self byGoodStartRequestData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_headView.timer invalidate];
}
- (void)byGoodStartRequestData
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.goods.byFlashSale.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone", time];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:BYGood];
}
- (void)byGoodSuccefull:(NSNotification *)notification
{
    NSData * data = notification.object;
    _receiveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"flashSale"];
    _headView.dic = [_receiveArray firstObject];
    [_tableView reloadData];
}
- (void)initWithHeaderView
{
    _headView = [[BYHeadView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];

}
- (void)initWithTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 120;
    [self.view addSubview:_tableView];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetailsViewController * goodsVC = [[GoodsDetailsViewController alloc] init];
    goodsVC.goodID = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"gid"];
    goodsVC.imageUrl = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"image"];
    goodsVC.begin = _headView.begin;
    [self.navigationController pushViewController:goodsVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _receiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentfier = @"cell";
    ByGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (!cell) {
        cell = [[ByGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dic = [_receiveArray objectAtIndex:indexPath.row];
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
