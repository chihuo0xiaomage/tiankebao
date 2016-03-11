//
//  BYSetViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-10-20.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYSetViewController.h"
#import "WeiPuLoginViewController.h"
#import "BYShopCartViewController.h"
#import "MyOrderViewController.h"


@interface BYSetViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray     * _titleArray;
}
@end

@implementation BYSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"设置";
        _titleArray = [NSArray arrayWithObjects:/*@"我的订单",*/ @"购物车", @"安全退出", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initWithTableView];
}
    //初始化控件
- (void)initWithTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentfier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_titleArray objectAtIndex:indexPath.row]];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Succeful"] && indexPath.row != 1) {
      WeiPuLoginViewController * weipuLogin = [[WeiPuLoginViewController alloc] init];
              UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:weipuLogin];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }else if (indexPath.row == 1 && ![[NSUserDefaults standardUserDefaults] objectForKey:@"Succeful"]){
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,您还没有登录呀!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil] show];
        return;
    }
    
    switch (indexPath.row) {
//        case 0:{
//            [self mySelfInformation];
//        }
            break;
        case 0:{
            [self shopCart];
        }
            break;
        case 1:{
            [self quitLogin];
        }
        default:
            break;
    }
}
- (void)mySelfInformation
{
    [self.navigationController pushViewController:[[MyOrderViewController alloc] init] animated:YES];
}
- (void)shopCart
{
    BYShopCartViewController * byShopCart = [[BYShopCartViewController alloc] init];
    [self.navigationController pushViewController:byShopCart animated:YES];
}
- (void)quitLogin
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Succeful"];
   BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
    if (result) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,您已经退出了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
    }
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
