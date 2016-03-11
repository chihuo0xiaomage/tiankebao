//
//  BYCategoryProductsViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-14.
//  Copyright (c) 2014年 apple. All rights reserved.
//
#import "BYCategoryProductsViewController.h"
#import "BYCategoryProductsTableViewCell.h"
#import "NetWorking.h"
#import "Encrypt.h"
#import "BYCatelogs.h"
#import "BYMerchandiseViewController.h"
#import "MBProgressHUD.h"
static NSString * const categoryProducts = @"categoryProducts";
static NSString * const rightTableViewRequest = @"rightTableViewRequest";
@interface BYCategoryProductsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
        //接受网络请求回来的数据
    NSArray        * _receiveArray;
        //
    NSMutableArray * _categorysArray;
    UITableView    * _tableView;
    UITableView    * _rightTableView;
    NSString       * _cid;
    
    NSMutableArray * _rightArray;
}
@end

@implementation BYCategoryProductsViewController
    //分类界面 
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _categorysArray = [NSMutableArray array];
        _receiveArray = [NSArray array];
        _rightArray = [NSMutableArray array];
        self.title = @"分类";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        //创建手势添加到self.view上面确定滑动方向只能向右
    UISwipeGestureRecognizer * swip =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeFrameAnimation:)];
    swip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swip];
        //创建分类的tableView
    [self initWithBYCategoryProductsTableView];
        //开始网络数据的请求
    [self startCategoryProducts];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:categoryProducts object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:rightTableViewRequest object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        //通知传值 回调方法
        //一级分类的数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succefulCategoryProducts:) name:categoryProducts object:nil];
        //二级分类
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rightTableViewSucceful:) name:rightTableViewRequest object:nil];
}
    //手势的方法
- (void)changeFrameAnimation:(UISwipeGestureRecognizer *)swip
{
    [UIView beginAnimations:@"animation" context:nil];
    if (_tableView != nil) {
        
    _tableView.frame = self.view.frame;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //此方法有问题, 我们只能找到当前界面上显示的cell
        NSArray * array = [_tableView visibleCells];
        for (BYCategoryProductsTableViewCell * cell in array) {
                //显示cell上面的aImageView
            cell.aImageView.hidden = NO;
        }
            //改变右边的TableView的frame
    _rightTableView.frame = CGRectMake(320, _tableView.frame.origin.y + 64, _tableView.bounds.size.width, _rightTableView.frame.size.height);
    }
    [UIView commitAnimations];
}
- (void)startCategoryProducts
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
        //获取当前的时间戳
    CGFloat time = [Encrypt timeInterval];
        //拼接所有使用到的键值对
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.product.catelogy.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&isDescription=false&isIcon=false&catelogId=0", time];
        //进行加密
    NSString * sign = [Encrypt generate:keyValues];
        //拼接url
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
        //开始真正意义上的数据请求
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:categoryProducts];
}
    //请求成功后的回调方法
- (void)succefulCategoryProducts:(NSNotification *)notion
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSData * data = notion.object;
    if (data != NULL) {
        _receiveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"catelogs"];
    }
        //使用快速遍历法,进行数据的封装
    for (NSDictionary * catelogs in _receiveArray) {
        if ([[catelogs valueForKeyPath:@"status"] integerValue]) {
            BYCatelogs * catelog = [[BYCatelogs alloc] initWithCatelogDictionary:catelogs];
            [_categorysArray addObject:catelog];
        }
        
    }
        //刷新tableView
    [_tableView reloadData];
}
    //创建tableView
- (void)initWithBYCategoryProductsTableView
{
        //进入分类界面显示的tableView
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
        //进入分类界面隐藏的TableView
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(320, _tableView.frame.origin.y + 64, _tableView.bounds.size.width, _tableView.bounds.size.height - 64 - 49) style:UITableViewStylePlain];
    _rightTableView.layer.borderWidth = 1.0;
    _rightTableView.layer.borderColor = BACKGROUND_COLOR.CGColor;
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    [self.view addSubview:_rightTableView];
}
    //进行二级分类数据的请求
- (void)rightTableViewRequest
{
        //同上
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.catelogy.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&isDescription=false&isIcon=false&catelogId=%@", time, _cid];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:rightTableViewRequest];
}
- (void)rightTableViewSucceful:(NSNotification *)notiofication
{
        //接受网络请求回来的数据
    NSData * data = notiofication.object;
        //进行数据的解析
    NSArray * array = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"catelogs"];
        //进行判断数据是否为空
    [_rightArray removeAllObjects];
    for (NSDictionary * dic in array) {
       
        if ([[dic objectForKey:@"status"] integerValue]) {
            [_rightArray addObject:dic];
        }
    }
    //刷新界面
        [_rightTableView reloadData];
    
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [UIView beginAnimations:@"animation" context:nil];
        //判断tableview
    if (tableView == _tableView) {
            //取消选择
            //[_tableView deselectRowAtIndexPath:indexPath animated:YES];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.frame = CGRectMake(-50, _tableView.frame.origin.y, _tableView.bounds.size.width, _tableView.bounds.size.height);
    NSArray * array = [_tableView visibleCells];
    for (BYCategoryProductsTableViewCell * cell in array) {
        cell.aImageView.hidden = YES;
    }
    _rightTableView.frame = CGRectMake(120, _tableView.frame.origin.y + 64, _tableView.bounds.size.width, _rightTableView.bounds.size.height);
        _cid = ((BYCatelogs *)[_categorysArray objectAtIndex:indexPath.row]).cid;
            //开始进行右边的数据请求
        [self rightTableViewRequest];
        [_tableView reloadData];
        
    }else if (tableView == _rightTableView){
            //推出下一个界面
        BYMerchandiseViewController * byMerchandise = [[BYMerchandiseViewController alloc] init];
            //属性传值, 三级界面数据的请求需要使用到二级界面的cid;
        byMerchandise.cid = [[_rightArray objectAtIndex:indexPath.row] objectForKey:@"cid"];
        byMerchandise.title = [[_rightArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        [self.navigationController pushViewController:byMerchandise animated:YES];
    }
    [UIView commitAnimations];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        return 60;
    }
    return 40;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        return _categorysArray.count;
    }
    return _rightArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
    static NSString * CellIdentfier = @"cell";
    BYCategoryProductsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell == nil) {
        cell = [[BYCategoryProductsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
    }
    cell.byCatelogs = [_categorysArray objectAtIndex:indexPath.row];
        return cell;
    }
    static NSString * rightCellidentfier = @"rightCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:rightCellidentfier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightCellidentfier];
    }
    cell.textLabel.text = [[_rightArray objectAtIndex:indexPath.row] objectForKey:@"name"];
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
