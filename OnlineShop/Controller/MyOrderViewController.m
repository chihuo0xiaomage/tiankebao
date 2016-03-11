//
//  MyOrderViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-11-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyOrderViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "MyOrderTableViewCell.h"
#import "ForOrderPayViewController.h"
static NSString * const myOrder = @"myOrder";
@interface MyOrderViewController ()
{
    UITableView * _tabelView;
    NSArray     * _receoveArray;
}
@end

@implementation MyOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"订单管理";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myOrderResult:) name:myOrder object:nil];
    [self myOrderStartQuestData];
    _tabelView = [self tableViewWithFrame:self.view.frame];
    [self.view addSubview:_tabelView];
}
- (UITableView *)tableViewWithFrame:(CGRect)frame
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc]init];
    [tableView setDelegate:(id<UITableViewDelegate>)self];
    [tableView setDataSource:(id<UITableViewDataSource>)self];
        //tableView.tableHeaderView.tintColor = [UIColor yellowColor];
    tableView.showsVerticalScrollIndicator = NO;
    return tableView;
}
- (void)myOrderStartQuestData
{
    
    NSString * orderSn = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderSn"];
        //NSLog(@"%@", orderSn);
    CGFloat time = [Encrypt timeInterval];
        //拼接接口
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.product.order.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&memberId=%@&pageSize=10&pageNumber=1", time, MEMBERID];
        //进行加密
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        //NSLog(@"%@", urlStr);
        //开始网络请求
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:myOrder];
}
- (void)myOrderResult:(NSNotification *)notification
{
    NSData * data = [notification object];
//    NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:0 error:nil]);
    if (data != NULL) {
         _receoveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"order"];
        [_tabelView reloadData];
    }
   
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ForOrderPayViewController * forOrderPayVC = [[ForOrderPayViewController alloc] init];
    forOrderPayVC.receiveDic = [_receoveArray objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:forOrderPayVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
#pragma mark - UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"订单:%ld", (long)section];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _receoveArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_receoveArray objectAtIndex:section] objectForKey:@"goods"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * Cellidentfier = @"cell";
    MyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Cellidentfier];
    if (cell == nil) {
        cell = [[MyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellidentfier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.dic = [[[_receoveArray objectAtIndex:indexPath.section] objectForKey:@"goods"] objectAtIndex:indexPath.row];
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
