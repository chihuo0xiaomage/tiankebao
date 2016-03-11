//
//  BYRecommendViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-9-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BYRecommendViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "BYCollectionViewCell.h"
#import "GoodsDetailsViewController.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
static NSString * const recommend = @"recommend";
@interface BYRecommendViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray * _receiveArray;
    UICollectionView * _collectionView;
    int _pageNumber;
    
}
@property(nonatomic, assign)BOOL header;
@property(nonatomic, assign)BOOL footer;
@property(nonatomic, assign)BOOL first;
@end

@implementation BYRecommendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _pageNumber = 1;
        self.first = YES;
        self.title = @"商品";
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:recommend object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(byRecommendSucceful:) name:recommend object:nil];
    [self initWithBYRecommendCollectionView];
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    [self headerRefreshing];
    [self footerRefreshing];
    [self byRecommendStartRequest:1];
}

- (void)headerRefreshing
{
    __block BYRecommendViewController *by = self;
    [_collectionView addHeaderWithCallback:^{
        by.header = YES;
        [by startRequest];
    }];
}
- (void)footerRefreshing
{
    __unsafe_unretained typeof(self) by = self;
    [_collectionView addFooterWithCallback:^{
         by.footer = YES;
        [by startRequest];
    }];
}
- (void)startRequest
{
    if (_header) {
        _pageNumber = 1;
        [self byRecommendStartRequest:_pageNumber];
    }
    if (_footer) {
        _pageNumber ++;
        [self byRecommendStartRequest:_pageNumber];
    }
}
- (void)byRecommendStartRequest:(int)pageNumber
{
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat: @"appKey=00001&method=wop.product.search.goods.byRecommend.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&type=%@&pageSize=10&pageNumber=%d", time, self.notification.object, pageNumber];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP,keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:recommend];
}

- (void)byRecommendSucceful:(NSNotification *)nsnotification
{
    NSData * data = nsnotification.object;
    NSArray * array =[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"goods"];
    if (_first) {
        _receiveArray = [NSMutableArray arrayWithArray:array];
        [_collectionView reloadData];
        _first = NO;
    }
    if (_header) {
        _receiveArray = [NSMutableArray arrayWithArray:array];
        [_collectionView reloadData];
        [_collectionView headerEndRefreshing];
        _header = NO;
    }
    if (_footer) {
        [_receiveArray addObjectsFromArray:array];
        [_collectionView reloadData];
        [_collectionView footerEndRefreshing];
        _footer = NO;
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)initWithBYRecommendCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(145, 185);
    layout.sectionInset = UIEdgeInsetsMake(5, 10, 0, 10);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[BYCollectionViewCell class] forCellWithReuseIdentifier:@"UICOLLECTIONVIEW"];
    [self.view addSubview:_collectionView];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    GoodsDetailsViewController * goodVC = [[GoodsDetailsViewController alloc] init];
    goodVC.goodID = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"gid"];
    goodVC.imageUrl = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"image"];
    [self.navigationController pushViewController:goodVC animated:YES];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _receiveArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BYCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICOLLECTIONVIEW" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.dic = [_receiveArray objectAtIndex:indexPath.item];
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
