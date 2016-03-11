//
//  BYMerchandiseViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYMerchandiseViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "MerchandiseTableViewCell.h"
#import "MoreProductsViewController.h"
#import "MBProgressHUD.h"

static NSString * const merchandiseRequest = @"merchandiseRequest";
@interface BYMerchandiseViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray     * _receiveArray;
    NSMutableArray * _merchandiseArray;
}
@end

@implementation BYMerchandiseViewController

    //子分类界面
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            //self.title = @"商品";
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:merchandiseRequest object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(merchandiseRequestSucceful:) name:merchandiseRequest object:nil];
    [self initWithMerchandiseTableView];
    [self merchandiseRequest];
}
- (void)initWithMerchandiseTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
- (void)merchandiseRequest
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.catelogy.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&isDescription=false&isIcon=false&catelogId=%@", time, self.cid];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@",HTTP,keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:self action:@selector(merchandiseRequest) identifier:merchandiseRequest];
}
- (void)merchandiseRequestSucceful:(NSNotification *)notification
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSData * data = notification.object;
    _receiveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"catelogs"];
    [_tableView reloadData];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MoreProductsViewController * moreProducts = [[MoreProductsViewController alloc] init];
    moreProducts.cid = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"cid"];
    moreProducts.title = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    [self.navigationController pushViewController:moreProducts animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _receiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentfier = @"cell";
    MerchandiseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell == nil) {
        cell = [[MerchandiseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
