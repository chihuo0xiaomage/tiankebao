//
//  HYZCarViewController.m
//  WeiPeng
//
//  Created by 韩亚周 on 14-1-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "HYZCarViewController.h"

#import "mysql.h"

#import "HYZShoppingCarModel.h"

#import "MBProgressHUD.h"

@interface HYZCarViewController ()

@property (nonatomic, strong) HYZCarSmallView          *smallView;

@property (nonatomic, strong) ZBarReaderViewController *reader;

@end

@implementation HYZCarViewController

@synthesize barCodeString = _barCodeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"购物车";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (IOS7) {self.automaticallyAdjustsScrollViewInsets = NO;}
    
//    创建一个表
    [[mysql shareMysql] createTable:@"CREATE TABLE IF NOT EXISTS ShoppingCarTableView(DNAME text,DNUMBER text,DBARCODE text primary key,DPRICE text)"];
	
    self.view.backgroundColor = BACKGROUND_COLOR;
    
    _messageArray = [[NSMutableArray alloc] init];
    
    [self creatTableView];
    
    [self downSmallView];
    
    [self getGoodMessage];
}

- (void)downSmallView
{
    _smallView = [[HYZCarSmallView alloc] initWithFrame:CGRectMake(0, HEIGHT - 49 -94, WIDTH, 94)];
    _smallView.backgroundColor = [UIColor yellowColor];
        //_smallView.backgroundColor = [UIColor whiteColor];
    
    _smallView.delegate = self;
    
    [self.view addSubview:_smallView];
}

//创建表
- (void)creatTableView
{
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_HEIGHT, WIDTH, HEIGHT - NAVIGATION_HEIGHT - TABBAR_HEIGHT - 94) style:UITableViewStylePlain];
    
    _myTableView.delegate = self;
    
    _myTableView.dataSource = self;
    
    [self.view addSubview:_myTableView];
}

- (void)getGoodMessage
{
//    扫描成功以后，通过扫描成功的条形码请求该商品的信息
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    
    NSString *urlString = [NSString stringWithFormat:@"%@vipeng/web/shop/shop_barcode.do?barcode=%@",URL_HTTP,_barCodeString];
    
    HYZGoodMessageRequest *request = [[HYZGoodMessageRequest alloc] init];
    
    request.delegate = self;
    
    [request requestGoodMessage:urlString];
}

#pragma mark -
#pragma mark UITableViweDataSource -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_messageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
    HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:indexPath.row];
    
    HYZCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[HYZCarCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier tag:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        
        cell.cellDelegate = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.numberTextField.text = messageModel.DNUMBER;
    
    cell.goodNameLable.text = [NSString stringWithFormat:@"  商品名  %@",messageModel.DNAME];
    
    cell.priceLable .text = [NSString stringWithFormat:@" 价格 %@",messageModel.DPRICE];
    
    cell.priceLable.textColor = [UIColor redColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark -
#pragma mark HYZCARCELLDELEGATE -

- (void)cellImageButtonClicked:(UITapGestureRecognizer *)UITapGestureRecognizer
{
    HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:[[UITapGestureRecognizer.tag substringFromIndex:3] intValue]];
    
//    判断每个单元格上得删除按钮被点击
    if ([UITapGestureRecognizer.tag isEqualToString:[NSString stringWithFormat:@"dlt%d",[[UITapGestureRecognizer.tag substringFromIndex:3] intValue]]]){
        [
         [mysql shareMysql]deleteData:[NSString stringWithFormat:@"delete from ShoppingCarTableView where DBARCODE =%@",messageModel.DBARCODE]];
        
        [self valuationToMessageArray];
        
//        同步价格和数量
        [self fixSmallView];
        
        [_myTableView reloadData];
    }
    
//    判断每个单元格上得减少按钮被点击
    else if ([UITapGestureRecognizer.tag isEqualToString:[NSString stringWithFormat:@"sub%d",[[UITapGestureRecognizer.tag substringFromIndex:3] intValue]]]){
        
        [self valuationToMessageArray];
        
        HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:[[UITapGestureRecognizer.tag substringFromIndex:3] intValue]];
        
        if ([messageModel.DNUMBER intValue] > 1) {
            NSString *numberString = [NSString stringWithFormat:@"%d",[messageModel.DNUMBER intValue] - 1] ;
            
//        UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
            [[mysql shareMysql] update:[NSString stringWithFormat:@"update ShoppingCarTableView set DNUMBER =%@ WHERE DBARCODE=%@",numberString,messageModel.DBARCODE]];
        }
        else{return;}
        
        [self valuationToMessageArray];

//        同步价格和数量
        [self fixSmallView];
        
        [_myTableView reloadData];
    }
    
    //    判断每个单元格上得增加按钮被点击
    else{
        [self valuationToMessageArray];
        
        HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:[[UITapGestureRecognizer.tag substringFromIndex:3] intValue]];
        
        NSString *numberString = [NSString stringWithFormat:@"%d",[messageModel.DNUMBER intValue] + 1] ;
        
//        UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
        [[mysql shareMysql] update:[NSString stringWithFormat:@"update ShoppingCarTableView set DNUMBER =%@ WHERE DBARCODE=%@",numberString,messageModel.DBARCODE]];
    
        [self valuationToMessageArray];

//        同步价格和数量
        [self fixSmallView];
        
        [_myTableView reloadData];
    }
}

#pragma mark -
#pragma mark HYZGoodMessageRequestDelegate -

- (void)getGoodMessageSuccess:(NSArray *)messageArray
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self valuationToMessageArray];
    
//    如果没有商品，直接增加
    if ([_messageArray count] == 0) {
        [[mysql shareMysql]insert:[NSString stringWithFormat:@"INSERT OR REPLACE INTO ShoppingCarTableView(DNAME,DNUMBER,DBARCODE,DPRICE) values ('%@','%@','%@','%@')",[[messageArray objectAtIndex:0] objectForKey:@"DNAME"],@"1",[[messageArray objectAtIndex:0] objectForKey:@"DBARCODE"],[[messageArray objectAtIndex:0] objectForKey:@"DPRICE"]]];
    }
    else{
        for (int i = 0; i < [_messageArray count]; i ++) {
            HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:i];
            
//        如果数据库中已经有了这个商品，就显示该商品，并从数据库中选取该商品的数量显示个用户
            if ([messageModel.DBARCODE isEqualToString:[[messageArray objectAtIndex:0]objectForKey:@"DBARCODE"]]) {
                [[mysql shareMysql]insert:[NSString stringWithFormat:@"INSERT OR REPLACE INTO ShoppingCarTableView(DNAME,DNUMBER,DBARCODE,DPRICE) values ('%@','%@','%@','%@')",[[messageArray objectAtIndex:0] objectForKey:@"DNAME"],messageModel.DNUMBER,[[messageArray objectAtIndex:0] objectForKey:@"DBARCODE"],[[messageArray objectAtIndex:0] objectForKey:@"DPRICE"]]];
            }
//        如果数据库中没有这个商品，默认是一个商品
            else{
                [[mysql shareMysql]insert:[NSString stringWithFormat:@"INSERT OR REPLACE INTO ShoppingCarTableView(DNAME,DNUMBER,DBARCODE,DPRICE) values ('%@','%@','%@','%@')",[[messageArray objectAtIndex:0] objectForKey:@"DNAME"],@"1",[[messageArray objectAtIndex:0] objectForKey:@"DBARCODE"],[[messageArray objectAtIndex:0] objectForKey:@"DPRICE"]]];
            }
        }
    }
    [self valuationToMessageArray];
    
//        同步价格和数量
    [self fixSmallView];
//    刷新表
    [_myTableView reloadData];

//    如果产品过多，把表自动向上滚动
    if ([_messageArray count] > 4) {
        [_myTableView setContentOffset:CGPointMake(0,([_messageArray count] - 3) * 60)];
    }
}

//扫描或者请求失败，跳回根视图
- (void)requestFaild:(NSString *)faildString
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//对全局的_messageArray进行赋值
- (void)valuationToMessageArray{
    _messageArray =(NSMutableArray *)[[mysql shareMysql] show:[NSString stringWithFormat:@"select * from ShoppingCarTableView"]];
}

#pragma mark -
#pragma mark HYZCarSmallViewDelegate -

- (void)scanbuttonClicke
{
    if (_reader == NULL) {
        _reader = [[ZBarReaderViewController alloc] init];
        _reader.readerDelegate = self;
        
        _reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    }
        //设置自己定义的界面
    [self setOverlayPickerView:_reader];
    
    ZBarImageScanner *scanner = _reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    _reader.cameraViewTransform = CGAffineTransformMakeScale(1.5, 1.5);
    
    [self presentViewController:_reader animated:YES completion:nil];
}

    //自己定义的界面
- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
        //清除原有控件
    for (UIView *temp in [reader.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
            }
        }
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
            }
        }
    }
    
        //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    
    upView.alpha = 0.9;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:upView];
    
    
        //用于说明的label
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(15, 20, 290, 50);
    
    labIntroudction.numberOfLines=2;
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"将二维码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    
    [upView addSubview:labIntroudction];
    
    
        //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 20, 280)];
    
    leftView.alpha = 0.9;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:leftView];
    
    
        //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300, 80, 20, 280)];
    
    rightView.alpha = 0.9;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:rightView];
    
    
        //底部view
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 150)];
    
    downView.alpha = 0.9;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:downView];
    
        //用于取消操作的button
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    cancelButton.alpha = 0.4;
    
    [cancelButton setFrame:CGRectMake(20, 390, 280, 40)];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    
    [cancelButton addTarget:self action:@selector(dismissOverlayView:)forControlEvents:UIControlEventTouchUpInside];
    
    [reader.view addSubview:cancelButton];
}

- (void)dismissOverlayView:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =[info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    
    for(symbol in results)break;
    
    if (symbol.data) {
        _barCodeString = symbol.data;
        
        [self getGoodMessage];
        
        [reader dismissViewControllerAnimated:YES completion:nil];
    }
    else{[reader dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)fixSmallView
{
    [self valuationToMessageArray];

    NSMutableArray *numberMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSMutableArray *priceMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int a = 0; a < [_messageArray count]; a ++) {
        HYZShoppingCarModel  *messageModel = [_messageArray objectAtIndex:a];
        
        [numberMutableArray addObject:messageModel.DNUMBER];
        
        [priceMutableArray addObject:messageModel.DPRICE];
    }
    
    float number = 0;
    
    float price = 0;
    
    for (int x = 0; x < [numberMutableArray count]; x ++){
        number = [[numberMutableArray objectAtIndex:x] floatValue] + number;
        
        price = [[numberMutableArray objectAtIndex:x] floatValue] *[[priceMutableArray objectAtIndex:x] floatValue] + price;
        
    }
    _smallView.numberLable.text = [NSString stringWithFormat:@"%.0f",number];
    
    _smallView.priceLable.text = [NSString stringWithFormat:@"%.2f",price];
}

- (void)accountbuttonClicke
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [docDir stringByAppendingPathComponent:@"USERMESSAGE.plist"];
    
    NSArray *array = [[NSArray alloc]initWithContentsOfFile:filePath];
    
    if ([[array objectAtIndex:2] isEqualToString:@"登录成功"]){
        HYZSettlementViewController *settlementViewController = [[HYZSettlementViewController alloc] init];
        
        settlementViewController.numberStr = _smallView.numberLable.text;
        
        settlementViewController.priceStr = _smallView.priceLable.text;
        
        [self.navigationController pushViewController:settlementViewController animated:YES];
    }
    else{
        HYZLoginViewController *loginViewController = [[HYZLoginViewController alloc] init];
        
        loginViewController.delegate =self;
        
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
}

#pragma mark -
#pragma mark HYZLoginViewControllerDelegate -

- (void)loginSuccess
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
