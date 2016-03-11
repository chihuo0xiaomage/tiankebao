//
//  BYShopCartViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYShopCartViewController.h"
#import "CartTableViewCell.h"
#import "ManMessageViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "MBProgressHUD.h"
static NSString * const BYShopCart = @"BYShopCart";
static NSString * const deleteOrder = @"deleteOrder";
@interface BYShopCartViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    BOOL          _show;
    NSMutableArray * _indexPathArray;
    UIImageView * _imageView;
    UILabel     * _numberLabel;
    UIButton    * _balanceButton;
    NSMutableArray * _receiveArray;
    BOOL          _select;
    BOOL          _delete;
    float           _sum;
    NSMutableArray * _shopArray;
    BOOL          _start;
    int           _numberCount;
}
@end

@implementation BYShopCartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       self.title = @"购物车";
        _indexPathArray = [NSMutableArray array];
        _shopArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BYShopCart object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:deleteOrder object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(byShopCartRequestSucceful:) name:BYShopCart object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteSuccful:) name:deleteOrder object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRequestData) name:@"updateMain" object:nil];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteShop:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self initWitTableView];
    [self startRequestData];
}
#pragma mark - requestData
- (void)startRequestData
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.cart.item.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&memberId=%@", time, MEMBERID];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:BYShopCart];
}
- (NSMutableArray *)swapPlaces:(NSMutableArray *)array
{
    NSMutableArray * newArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        [newArray addObject:[array objectAtIndex:array.count - 1 - i]];
    }
    return newArray;
}
- (void)byShopCartRequestSucceful:(NSNotification *)nsnotification
{
    NSData * data = nsnotification.object;
    
    if (data == NULL) {
        return;
    }
    _receiveArray = [NSMutableArray arrayWithArray:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"cartItem"]];
       if (_receiveArray.count == 0) {
           [self performSelector:@selector(promptInformation) withObject:nil afterDelay:2.0];
        return;
    }
    _sum = 0;
    _numberCount = 0;
    for (NSDictionary * dic in _receiveArray)
    {
        _sum += [[dic objectForKey:@"price"] floatValue] * [[dic objectForKey:@"quantity"] floatValue];
        _numberCount += [[dic objectForKey:@"quantity"] intValue];
    }
    _numberLabel.text = [NSString stringWithFormat:@"%d件商品共计:￥%.2f", _numberCount, _sum];
    [_tableView reloadData];
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    
}
- (void)promptInformation
{
    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的购物车中还没有添加商品呀" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}
- (void)deleteShop:(UIBarButtonItem *)BarItem
{
    [self startDeleteOrder:_shopArray];
    if (_delete) {
        for (NSDictionary * dic in _shopArray) {
            if ([_receiveArray containsObject:dic]) {
                [_receiveArray removeObject:dic];
            }
        }
        _delete = NO;
    }
    _sum = 0;
    _numberCount = 0;
    for (NSDictionary * dic in _receiveArray) {
        _sum += [[dic objectForKey:@"price"] floatValue] * [[dic objectForKey:@"quantity"] floatValue];
        _numberCount += [[dic objectForKey:@"quantity"] intValue];
    }
    _numberLabel.text = [NSString stringWithFormat:@"%d件商品共计:￥%.2f", _numberCount, _sum];
    [_shopArray removeAllObjects];
    [_indexPathArray removeAllObjects];
    [_tableView reloadData];
}
- (void)startDeleteOrder:(NSMutableArray *)array
{
    CGFloat time = [Encrypt timeInterval];
    NSMutableArray * jsonArray = [NSMutableArray array];
    for (id shopDic in array) {
        NSString * cartItemId = [shopDic objectForKey:@"cid"];
        NSDictionary * dic = [NSDictionary dictionaryWithObject:cartItemId forKey:@"cartItemId"];
        [jsonArray addObject:dic];
    }
    if (jsonArray.count == 0) {
        return;
    }
    NSDictionary * jsonDic = [NSDictionary dictionaryWithObject:jsonArray forKey:@"cartItemDelList"];
    NSData * jsonData = [NSJSONSerialization  dataWithJSONObject:jsonDic options:0 error:nil];
    NSString * json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.cart.item.del&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&cartItemDelArray=%@", time, json];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:deleteOrder];
}
- (void)deleteSuccful:(NSNotification *)notification
{
    NSData * data = notification.object;
}
- (void)initWitTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    UIView * aview = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, 320, 49)];
    aview.layer.cornerRadius = 1.0;
    aview.layer.borderWidth = 1.0;
    aview.layer.borderColor = [UIColor grayColor].CGColor;
    aview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:aview];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 30, 30)];
    _imageView.image = [UIImage imageNamed:@"对号.png"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allSelect)];
    _imageView.userInteractionEnabled = YES;
    [_imageView addGestureRecognizer:tap];
    [aview addSubview:_imageView];
    
    _numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imageView.frame.origin.x + _imageView.bounds.size.width + 5, _imageView.frame.origin.y, 200, 30)];
    _numberLabel.text = @"0件商品共计:￥0.0";
    [aview addSubview:_numberLabel];

    
    _balanceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _balanceButton.frame = CGRectMake(_numberLabel.frame.origin.x + _numberLabel.bounds.size.width + 5, _numberLabel.frame.origin.y, 60, 30);
    [_balanceButton setTitle:@"结算(0)" forState:UIControlStateNormal];
    [_balanceButton addTarget:self action:@selector(balanceMoney) forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:_balanceButton];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
}
- (void)allSelect
{
    [_indexPathArray removeAllObjects];
    [_shopArray removeAllObjects];
    _select = !_select;
    _delete = YES;
    [_tableView reloadData];
}
- (void)balanceMoney
{
    if (_receiveArray.count == 0) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,您还没有添加要购买的商品呀!" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
        return;
    }
    ManMessageViewController * manMessager = [[ManMessageViewController alloc] init];
    manMessager.receiveArray = _receiveArray;
    manMessager.sendSumPrice = _numberLabel.text;
    [self.navigationController pushViewController:manMessager animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _select = NO;
    _delete = YES;
    NSString * indexPathRow = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    if ([_indexPathArray containsObject:indexPathRow]) {
        [_indexPathArray removeObject:indexPathRow];
        [_shopArray removeObject:[_receiveArray objectAtIndex:indexPath.row]];
    }else{
        [_indexPathArray addObject:indexPathRow];
        [_shopArray addObject:[_receiveArray objectAtIndex:indexPath.row]];
    }
    [tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _receiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentfier = @"cell";
    CartTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell == nil) {
        cell = [[CartTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
        cell.aImageView.image = [UIImage imageNamed:@"对号.png"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString * indexPathRow = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    if ([_indexPathArray containsObject:indexPathRow]) {
//        cell.aImageView.backgroundColor = [UIColor yellowColor];
        cell.aImageView.image = [UIImage imageNamed:@"叉号.png"];
    }else{
//        cell.aImageView.backgroundColor = [UIColor redColor];
        cell.aImageView.image = [UIImage imageNamed:@"对号.png"];
    }
    if (_select) {
//        cell.aImageView.backgroundColor = [UIColor redColor];
        cell.aImageView.image = [UIImage imageNamed:@"对号.png"];
    }
    cell.byShopCartDic = [_receiveArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
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
