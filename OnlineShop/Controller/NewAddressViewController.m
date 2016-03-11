//
//  NewAddressViewController.m
//  WeiPeng
//
//  Created by 宝源科技 on 14-8-7.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NewAddressViewController.h"
#import "NewAddressView.h"
#import "AreaView.h"
#import "Encrypt.h"
#import "NetWorking.h"
#define BACKGROUND_COLOR [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]
static NSString * const province = @"province";
static NSString * const city = @"city";
static NSString * const county = @"county";
static NSString * const save = @"save";
@interface NewAddressViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _receiveArray;
    BOOL          _province;
    BOOL          _city;
    BOOL          _county;
    NSString    * _cityID;
    NSString    * _countyID;
    NSInteger     _indexPath;
    NSString    * _areaId;
    NSString    * _path;
}
@property (nonatomic, retain)NewAddressView * consigneeView;
@property (nonatomic, retain)NewAddressView *
phoneView;
@property (nonatomic, retain)NewAddressView * addressView;
@property (nonatomic, retain)NewAddressView *
postcodeView;

@property (nonatomic, retain)NewAddressView * areaView;
@property (nonatomic, retain)UIView * aView;
@end

@implementation NewAddressViewController

    //新建收货地址
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _receiveArray = [NSMutableArray array];
        self.aView = [[UIView alloc] initWithFrame:self.view.frame];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changFrame)];
        [self.aView addGestureRecognizer:tap];
        [self.view addSubview:self.aView];
        
        [self initWithConsigneeView];
        [self initWithPhoneView];
        [self initWithAreaView];
        [self initWithAddressView];
        [self initWithPostcodeView];
        [self initWithTableView];
    }
    return self;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:save object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:province object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:city object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:county object:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:BACKGROUND_COLOR];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveSucceful:) name:save object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succefulData:) name:province object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succefulData:) name:city object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(succefulData:) name:county object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveAddress)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBackLastPage)];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        //NSLog(@"self.addressDic = %@", self.addressDic);
    if (_addressDic != NULL) {

            //NSLog(@"===== %@", [[_addressDic objectForKey:@"name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
        _consigneeView.textField.text = [NSString stringWithFormat:@"%@", [[_addressDic objectForKey:@"name"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _phoneView.textField.text = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"phone"]];
//        _areaView.provinceView.areaLabel.text = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"<#string#>"]]
        _addressView.textField.text = [NSString stringWithFormat:@"%@", [[_addressDic objectForKey:@"address"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        _postcodeView.textField.text = [NSString stringWithFormat:@"%@", [_addressDic objectForKey:@"zipCode"]];
    }
}
- (void)initWithTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 - 50) style:UITableViewStylePlain];
    _tableView.hidden = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
}
- (void)isTableViewEmpty
{
    _tableView.hidden = YES;
}
- (void)initWithConsigneeView
{
    self.consigneeView = [[NewAddressView alloc] initWithFrame:CGRectMake(0, 64, 320, 70) title:@"收货人:" placeholder:@"请输入姓名"];
    [self.aView addSubview:self.consigneeView];
}
- (void)initWithPhoneView
{
    self.phoneView = [[NewAddressView alloc] initWithFrame:CGRectMake(_consigneeView.frame.origin.x, _consigneeView.frame.origin.y + _consigneeView.bounds.size.height, 320, 70) title:@"手机:" placeholder:@"请输入手机号"];
    self.phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.aView addSubview:self.phoneView];
}
- (void)initWithAreaView
{
    self.areaView = [[NewAddressView alloc] initWithFrame:CGRectMake(self.phoneView.frame.origin.x, self.phoneView.frame.origin.y + self.phoneView.bounds.size.height, 320, 80) title:@"省份:" target:self action:@selector(startRequestData:)];
    [self.aView addSubview:self.areaView];
}
- (void)initWithAddressView
{
    self.addressView = [[NewAddressView alloc] initWithFrame:CGRectMake(self.areaView.frame.origin.x, self.areaView.frame.origin.y + self.areaView.bounds.size.height, 320, 70) title:@"地址:" placeholder:@"您的详细地址"];
    [self.aView addSubview:self.addressView];
}
- (void)initWithPostcodeView
{
    self.postcodeView = [[NewAddressView alloc] initWithFrame:CGRectMake(self.addressView.frame.origin.x, self.addressView.frame.origin.y + self.addressView.bounds.size.height, 320, 70) title:@"邮编:" placeholder:@"您要寄往地区的邮编号"];
    self.postcodeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.aView addSubview:self.postcodeView];
}
- (void)changFrame
{
    [self.consigneeView.textField resignFirstResponder];
    [self.phoneView.textField resignFirstResponder];
    [self.addressView.textField resignFirstResponder];
    [self.postcodeView.textField resignFirstResponder];
    self.aView.frame = self.view.frame;
}
#pragma mark - UIButton
- (void)goBackLastPage
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)saveAddress
{
    [self.consigneeView.textField resignFirstResponder];
    [self.phoneView.textField resignFirstResponder];
    [self.addressView.textField resignFirstResponder];
    [self.postcodeView.textField resignFirstResponder];
    self.aView.frame = self.view.frame;
    if ([self.consigneeView.textField.text isEqualToString:@"" ] || [self.addressView.textField.text isEqualToString:@""] || [self.phoneView.textField.text isEqualToString:@""] || [self.postcodeView.textField.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的信息填写不完整" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
       // return;
    }
    else{
    NSString * name = [self.consigneeView.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * address = [self.addressView.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    CGFloat time = [Encrypt timeInterval];
    NSString * strUrl;
        //NSLog(@"self.addressDic = %@", self.addressDic);
   // if (!self.addressDic) {
            //NSLog(@"**************");
//        NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.receiver.mod&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&receiverId=%@&memberId=%@&name=%@&areaId=%@&areaPath=%@&address=%@&zipCode=%@&phone=%@&isDefault=1",time, [self.addressDic objectForKey:@"rId"], MEMBERID, name,_areaId, _path, address,self.postcodeView.textField.text, self.phoneView.textField.text];
//        NSString * sign = [Encrypt generate:keyValues];
//        strUrl = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
//    }
//else{
    NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.product.receiver.add&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&memberId=%@&name=%@&areaId=%@&areaPath=%@&address=%@&zipCode=%@&phone=%@&isDefault=1",time, MEMBERID,name,_areaId, _path, address,self.postcodeView.textField.text, self.phoneView.textField.text];
    NSString * sign = [Encrypt generate:keyValues];
    strUrl = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
   // }
   
    [NetWorking NetWorkingURL:strUrl target:nil action:nil identifier:save];
    }
}
- (void)saveSucceful:(NSNotification *)notification
{
    NSData * data = notification.object;
    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSString * resultCode =[NSString stringWithFormat:@"%@", [dic objectForKey:@"resultCode"]];
    NSLog(@"保存成功%@",resultCode);
    if ([resultCode isEqualToString:@"99"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)startRequestData:(UIButton *)button
{
    [self.consigneeView.textField resignFirstResponder];
    [self.phoneView.textField resignFirstResponder];
    [self.addressView.textField resignFirstResponder];
    [self.postcodeView.textField resignFirstResponder];
    _tableView.hidden = NO;
    if (button == self.areaView.provinceView.button) {
        self.areaView.cityView.areaLabel.text = @"";
        self.areaView.countyView.areaLabel.text = @"";
        _province = !_province;
        CGFloat time = [Encrypt timeInterval];
        NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.area.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&areaId=0",time];
        NSString * sign = [Encrypt generate:keyValues];
        NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
        [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:province];
    }else if (button == self.areaView.cityView.button){
        self.areaView.countyView.areaLabel.text = @"";
        _city = !_city;
        if (_receiveArray.count != 0) {
        _cityID = [[_receiveArray objectAtIndex:_indexPath] objectForKey:@"aId"];
        }
        CGFloat time = [Encrypt timeInterval];
        NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.area.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&areaId=%@",time, _cityID];
        NSString * sign = [Encrypt generate:keyValues];
        NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
        [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:city];
    }else if (button == self.areaView.countyView.button){
        _county = !_county;
        if (_receiveArray.count != 0) {
            _countyID = [[_receiveArray objectAtIndex:_indexPath] objectForKey:@"aId"];
        }
        CGFloat time = [Encrypt timeInterval];
        NSString * keyValues = [NSString stringWithFormat:@"appKey=00001&method=wop.area.list.get&v=1.0&format=json&locale=zh_CN&timestamp=%.0f&client=iPhone&areaId=%@",time, _countyID];
        NSString * sign = [Encrypt generate:keyValues];
        NSString * urlStr = [NSString stringWithFormat:@"%@?%@&sign=%@", HTTP, keyValues, sign];
        [NetWorking NetWorkingURL:urlStr target:nil action:nil identifier:county];
    }
}
- (void)succefulData:(NSNotification *)notification
{
    NSData * data = notification.object;
    _receiveArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"areas"];
        //NSLog(@"%@", _receiveArray);
    [_tableView reloadData];
    if (_receiveArray.count == 0) {
        _tableView.hidden = YES;
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    _tableView.hidden = YES;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath.row;
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (_province) {
        self.areaView.provinceView.areaLabel.text = cell.textLabel.text;
        _province = NO;
    }else if (_city){
        self.areaView.cityView.areaLabel.text = cell.textLabel.text;
        _city = NO;
    }else{
        
        self.areaView.countyView.areaLabel.text = cell.textLabel.text;
    }
    tableView.hidden = YES;
    if (_receiveArray.count != 0) {
        _areaId = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"aId"];
        _path = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"path"];
            //NSLog(@"%@", _areaId);
    }
}
#pragma mark - UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        //NSLog(@"%d", _receiveArray.count);
    return _receiveArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentfier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentfier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentfier];
    }
    cell.textLabel.text = [[_receiveArray objectAtIndex:indexPath.row] objectForKey:@"name"];
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
