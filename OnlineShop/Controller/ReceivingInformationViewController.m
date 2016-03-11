//
//  ReceivingInformationViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-6-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ReceivingInformationViewController.h"
#import "NewAddressViewController.h"
#import "Encrypt.h"
#import "NetWorking.h"
#import "MessageTableViewCell.h"
#import "MBProgressHUD.h"
static NSString * const ManMessage = @"ManMessage";
static NSString * const deleteAddress = @"deleteAddress";
@interface ReceivingInformationViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _receiveArray;
}
@end

@implementation ReceivingInformationViewController

    //收货人信息
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"收货人信息";
            //_receiveArray = [NSMutableArray array];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ManMessage object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:deleteAddress object:nil];
}
- (void)hello
{
        //NSLog(@"*********@");
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succefulLoadData:) name:ManMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAddressSucceful:) name:deleteAddress object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changAddress:) name:@"changeAddress" object:nil];
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"新建地址" style:UIBarButtonItemStyleDone target:self action:@selector(newAddress)];
    self.navigationItem.rightBarButtonItem = rightBarItem;

    [self initWithTableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startRequestData];
}
- (void)initWithTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}
- (void)startRequestData
{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = NSLocalizedString(@"加载中...", nil);
    CGFloat time = [Encrypt timeInterval];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.receiver.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&memberId=%@", time, MEMBERID];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * strUrl = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
    [NetWorking NetWorkingURL:strUrl target:nil action:nil identifier:ManMessage];
    
}
- (void)succefulLoadData:(NSNotification *)notification
{
    NSData * data = notification.object;
    _receiveArray = [NSMutableArray arrayWithArray:[[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"receivers"]];
    [_tableView reloadData];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (editingStyle == UITableViewCellEditingStyleDelete){
       [self deleteAddress:[_receiveArray objectAtIndex:indexPath.row]];
        [_receiveArray removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
}
- (void)deleteAddress:(NSDictionary *)dic
{
    CGFloat time = [Encrypt timeInterval];
//    NSLog(@"%@", dic);
    NSString * receiverId = [dic objectForKey:@"rId"];
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.receiver.del&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&receiverId=%@", time, receiverId];
    NSString * sign = [Encrypt generate:keyValues];
    NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
    [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:deleteAddress];
}
- (void)deleteAddressSucceful:(NSNotification *)notification
{
    NSData * data = notification.object;
    NSString * resultCode = [NSString stringWithFormat:@"%@", [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"resultCode"]];
        //NSLog(@"***************%@", resultCode);
    if ([resultCode isEqualToString:@"0"]) {
            //NSLog(@"****************ios456");
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"address"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSUserDefaults standardUserDefaults] setObject:[_receiveArray objectAtIndex:indexPath.row] forKey:@"address"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark - UITableViewDataSource
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
    MessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentfier];
    if (cell==nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentfier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.messageDic = [_receiveArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)newAddress
{
    NewAddressViewController * newAddress = [[NewAddressViewController alloc] init];
    newAddress.title = @"新建收货地址";
    [self.navigationController pushViewController:newAddress animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
#pragma mark - NSNotificationCenter
- (void)changAddress:(NSNotification *)notification
{
    NewAddressViewController * newAddressVC = [[NewAddressViewController alloc] init];
    newAddressVC.addressDic = notification.object;
    newAddressVC.title = @"修改收货地址";
    [self.navigationController pushViewController:newAddressVC animated:YES];
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
