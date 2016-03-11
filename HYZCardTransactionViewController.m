//
//  HYZCardTransactionViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 13-12-23.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "HYZCardTransactionViewController.h"

@interface HYZCardTransactionViewController ()

@end

@implementation HYZCardTransactionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"卡包";
        
        self.navigationItem.title = @"卡包";
    
        self.tabBarItem.image = [UIImage imageNamed:@"Main.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imageNameArray = [[NSArray alloc] initWithObjects:@"Main.png",@"Mine.png",@"Car.png", @"More.png",@"search.png",@"Main.png", @"Mine.png",@"Car.png",nil];
    
    _titleArray = [[NSArray alloc] initWithObjects:@"充值",@"兑换",@"吹一吹", @"摇一摇",@"闪付",@"便民服务", @"EDM",@"Car.png", nil];

    
    if (IOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    static NSString *cellIdentifier = @"CellIdentifier";
//    
//    HYZCardTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell)
//    {
//        cell = [[HYZCardTransactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier imageNameArray:_imageNameArray titleLableNameArray:_titleArray];
//        
//        cell.delegate = self;
//        
//        cell.backgroundColor = [UIColor lightGrayColor];
//        
////        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        cell.selected = NO;
//    }
//    return cell;
    
//    static NSString *cellIdentifier = @"CellIdentifier";
//    
//    HYZCardTransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell)
//    {
    if (indexPath.row == 0)
    {
        HYZScrollViewCell *cell = [[HYZScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil imageNameArray:_imageNameArray];
        
        cell.scrollViewImageDelegate = self;
        
        cell.selected = NO;

        return cell;
    }
    else
    {
        HYZCardTransactionCell *cell = [[HYZCardTransactionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil imageNameArray:_imageNameArray titleLableNameArray:_titleArray];
        
        cell.delegate = self;
        
        cell.backgroundColor = [UIColor lightGrayColor];
        
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.selected = NO;

        return cell;
    }

}

#pragma mark -
#pragma mark HYZCardTransactionScrollViewDelegate -

- (void)buttonClicked:(NSString *)tag
{
}

#pragma mark -
#pragma mark HYZCardTransactionScrollViewDelegate -

- (void)scrollViewImageClicked:(NSString *)tag
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
