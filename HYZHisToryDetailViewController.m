//
//  HYZHisToryDetailViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-18.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZHisToryDetailViewController.h"

#import "MBProgressHUD.h"

@interface HYZHisToryDetailViewController ()

@end

@implementation HYZHisToryDetailViewController

@synthesize barCodeString = _barCodeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    if (IOS7){self.automaticallyAdjustsScrollViewInsets = NO;}
    
    _messageArray = [[NSArray alloc] init];
    
    [self creatTopView];
    
    [self creatDownView];
    
    [self creatTableView];
    
    [self getMessageRequest];
}

- (void)creatTopView
{
    _topView = [[HYZSureTopView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, 65)];
    
    _topView.backgroundColor = [UIColor whiteColor];
    
    _topView.barCodeLable.text = _barCodeString;
    
    [self.view addSubview:_topView];
}

- (void)creatTableView
{
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT + 66, WIDTH, HEIGHT - NAVIGATION_HEIGHT - TABBAR_HEIGHT - 66 - 130) style:UITableViewStylePlain];
    
    _messageTableView.dataSource = self;
    
    _messageTableView.delegate = self;
    
    [self.view addSubview:_messageTableView];
}

- (void)creatDownView
{
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - TABBAR_HEIGHT - 129, 320, 129)];
    
    downView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:downView];
    
    
//     生成条形码图片
    UIImage *image = [UIImage imageFromBarcode:[[NKDEAN13Barcode alloc] initWithContent:_barCodeString]];
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
    
    imageview.frame = CGRectMake(30, 0,image.size.width,image.size.height);
    
    [downView addSubview:imageview];
    
    
//    创建确认按钮
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sureButton setBackgroundColor:[UIColor colorWithRed:230.0/255.0 green:121.0/255.0 blue:23.0/255.0 alpha:1]];
    
    sureButton.frame = CGRectMake(15, image.size.height + 5, 290, 35);
    
    [sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [sureButton addTarget:self action:@selector(sureButtonclicked) forControlEvents:UIControlEventTouchUpInside];
    
    [downView addSubview:sureButton];
}

- (void)getMessageRequest
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/shop/jiaoyi_detial.do?barcode=%@",URL_HTTP,_barCodeString];
    
    HYZDetailMSGRequest *request = [[HYZDetailMSGRequest alloc] init];
    
    request.delegare = self;
    
    [request getShoppingDetailMessageRequset:urlString];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZConsumeDetailModel *model = [[HYZConsumeDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:indexPath.row] error:nil];
    
    HYZSettlementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZSettlementCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.nameLable.text = model.DNAME;
    
    cell.numberLable.text = model.DNUM;
    
    cell.priceLable.text = model.DPRICE;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark HYZDetailMSGRequestDelegate -

- (void)getShoppingDetailMessageSuccess:(NSArray *)messsageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    _messageArray = messsageArray;
    
    [self fixSmallView:_messageArray];
    
    [_messageTableView reloadData];
}

- (void)fixSmallView:(NSArray *)messageArray
{
    NSMutableArray *numberMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray *priceMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int a = 0; a < [_messageArray count]; a ++) {
        
        HYZConsumeDetailModel *model = [[HYZConsumeDetailModel alloc] initWithDictionary:[_messageArray objectAtIndex:a] error:nil];

        [numberMutableArray addObject:model.DNUM];
        
        [priceMutableArray addObject:model.DPRICE];
    }
    
    float number = 0;
    
    float price = 0;
    
    for (int x = 0; x < [numberMutableArray count]; x ++){
        number = [[numberMutableArray objectAtIndex:x] floatValue] + number;
        
        price = [[numberMutableArray objectAtIndex:x] floatValue] *[[priceMutableArray objectAtIndex:x] floatValue] + price;
    }
    _topView.numberLable.text = [NSString stringWithFormat:@"%.0f",number];
    
    _topView.moneyLable.text = [NSString stringWithFormat:@"%.2f",price];
}

- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              
                              initWithTitle:faildString
                              
                              message:@"请检查您的网络设置"
                              
                              delegate:nil
                              
                              cancelButtonTitle:@"确定"
                              
                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)sureButtonclicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
