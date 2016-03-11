//
//  HYZSureViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZSureViewController.h"

#import "mysql.h"

@interface HYZSureViewController ()

@end

@implementation HYZSureViewController

@synthesize barCodeNUmberString = _barCodeNUmberString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"确认";
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIScreen mainScreen] setBrightness:0.5];
    
    [super viewWillDisappear:animated];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc] initWithTitle:@"<快购" style:UIBarButtonItemStylePlain target:self action:@selector(sureButtonclicked)];
    
    self.navigationItem.leftBarButtonItem=backitem;
    
    
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    [[UIScreen mainScreen] setBrightness:1.0];
    
    _messageArray = [[NSArray alloc] init];
    
    _messageArray =(NSMutableArray *)[[mysql shareMysql] show:[NSString stringWithFormat:@"select * from ShoppingCarTableView"]];
    
    [self creatTopView];
    
    [self creatDownView];
    
    [self creatTableView];
}

- (void)creatTopView
{
    HYZSureTopView *topView = [[HYZSureTopView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, 65)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    topView.barCodeLable.text = _barCodeNUmberString;
    
    topView.numberLable.text = _allNumberString;
    
    topView.moneyLable.text = _moneyString;
    
    [self.view addSubview:topView];
}

- (void)creatDownView
{
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - TABBAR_HEIGHT - 130, 320, 130)];
    
    downView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:downView];
    
    
//     生成条形码图片
    UIImage *image = [UIImage imageFromBarcode:[[NKDEAN13Barcode alloc] initWithContent:_barCodeNUmberString]];
    
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

- (void)creatTableView
{
    _sureTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT + 66, WIDTH, HEIGHT - NAVIGATION_HEIGHT - TABBAR_HEIGHT - 65 - 130 -2) style:UITableViewStylePlain];
    
    _sureTableView.dataSource = self;
    
    _sureTableView.delegate = self;
    
    [self.view addSubview:_sureTableView];
    
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    [[NSFileManager defaultManager] changeCurrentDirectoryPath:[documentsDirectory stringByExpandingTildeInPath]];
    
    NSString *fileName1 = @"data.sqlite";
    
    NSArray *fileList = [[NSArray alloc] init];
    
    fileList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    [[NSFileManager defaultManager] removeItemAtPath:fileName1 error:nil];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

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
    
    HYZShoppingCarModel *model = [_messageArray objectAtIndex:indexPath.row];
    
    HYZSettlementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZSettlementCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.nameLable.text = model.DNAME;
    
    cell.numberLable.text = model.DNUMBER;
    
    cell.priceLable.text = model.DPRICE;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
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
